import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:faketify/constants/colors.dart';
import 'package:faketify/appstatestore.dart';

import '../../../music_player/models/playlist.dart';
import '../../../music_player/models/song.dart';
import '../../../music_player/music_player.dart';

class LikedSongPage extends StatefulWidget {
  const LikedSongPage({super.key});

  @override
  State<LikedSongPage> createState() => _LikedSongPageState();
}

class _LikedSongPageState extends State<LikedSongPage> {
  late List<Song> _likedSongs = [];
  late int _userId;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AppStateStore>(context, listen: false);
    _userId = provider.userId!;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _init();
      setState(() {});
    });
  }

  Future<void> _init() async {
    _likedSongs = await Song.getLikedSongs(_userId);
  }

  @override
  Widget build(BuildContext context) {
    if (_likedSongs.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Liked Songs',
            style: TextStyle(color: ColorConstants.darkWhite),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: ColorConstants.darkWhite),
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: _likedSongs.length,
            itemBuilder: (context, index) {
              final songResult = _likedSongs[index];
              final metadata = songResult.metadata!;
              final playlist = Playlist.song(songResult);
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(playlist: playlist),
                    ),
                  )
                },
                child: Slidable(
                  key: Key(songResult.songId.toString()),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) async {
                          await songResult.removeFavorite(_userId);
                          setState(() {
                            _likedSongs.removeAt(index);
                          });
                        },
                        backgroundColor: ColorConstants.errorColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        spacing: 0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        child: ClipOval(
                          child: CachedNetworkImage(
                              imageUrl: metadata.artUri.toString()),
                        ),
                      ),
                      title: Text(
                        metadata.title,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(color: ColorConstants.darkWhite),
                      ),
                      subtitle: Text(
                        metadata.artist!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style:
                            const TextStyle(color: ColorConstants.darkestWhite),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liked Songs',
          style: TextStyle(color: ColorConstants.darkWhite),
        ),
        backgroundColor: ColorConstants.backgroundColor,
        iconTheme: const IconThemeData(color: ColorConstants.darkWhite),
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: const Center(
          child: Text(
            'No Liked Songs',
            style: TextStyle(color: ColorConstants.darkWhite),
          ),
        ),
      ),
    );
  }
}
