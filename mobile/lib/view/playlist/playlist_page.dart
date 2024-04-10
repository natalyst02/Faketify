import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:faketify/constants/colors.dart';
import 'package:faketify/appstatestore.dart';

import '../music_player/models/song.dart';
import '../music_player/models/playlist.dart';
import '../music_player/music_player.dart';
import 'widgets/sliver_app_bar_widget.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key, required this.playlist});

  final Playlist playlist;

  @override
  State<PlaylistPage> createState() => _PlaylistState();
}

class _PlaylistState extends State<PlaylistPage> {
  late int _userId;
  late Playlist _playlist;
  late List<Song> _playlistSongs = [];

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AppStateStore>(context, listen: false);
    _userId = provider.userId!;
    _playlist = widget.playlist;
    _playlistSongs = _playlist.songList;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.playlist.fetchData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(playlist: _playlist),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MusicPlayer(playlist: _playlist))),
                      child: const Icon(
                        Icons.play_arrow,
                        size: 35,
                      ),
                    )),
                const SizedBox(height: 16),
                const Text('Featured',
                    style: TextStyle(
                        color: ColorConstants.darkWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w700)),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 5,
                      thickness: 0.5,
                      color: ColorConstants.darkestWhite,
                    );
                  },
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _playlistSongs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final song = _playlistSongs[index];
                    return Slidable(
                      key: Key(song.songId.toString()),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (context) async {
                              await _playlist.remove(_userId, song.songId);
                              setState(() {
                                _playlistSongs.removeAt(index);
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
                      child: Card(
                        color: ColorConstants.backgroundColor,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicPlayer(
                                        playlist: _playlist,
                                        initPos: index,
                                      ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              song.metadata!.artUri.toString()),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.metadata!.title,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: ColorConstants.darkWhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        song.metadata!.artist!,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: ColorConstants.darkestWhite),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
