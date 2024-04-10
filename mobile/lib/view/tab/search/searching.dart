import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faketify/constants/colors.dart';

import '../../music_player/music_player.dart';
import '../../music_player/models/song.dart';
import '../../music_player/models/playlist.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, required this.searchResults});

  final List<Song> searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Results',
          style: TextStyle(color: ColorConstants.darkWhite),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: ColorConstants.darkWhite),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final songResult = searchResults[index];
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
              child: SizedBox(
                child: ListTile(
                  leading: Container(
                    height: 50,
                    child: ClipOval(
                      child: CachedNetworkImage(
                          imageUrl: metadata.artUri.toString()),
                    ),
                  ),
                  title: Text(metadata.title,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(color: ColorConstants.darkWhite)),
                  subtitle: Text(metadata.artist!,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style:
                          const TextStyle(color: ColorConstants.darkestWhite)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
