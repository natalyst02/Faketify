import 'package:cached_network_image/cached_network_image.dart';
import 'package:faketify/appstatestore.dart';
import 'package:faketify/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../music_player/models/playlist.dart';
import '../../../music_player/models/song.dart';
import '../../../music_player/music_player.dart';

class Recommended extends StatefulWidget {
  const Recommended({super.key});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  late List<Song> _songs;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AppStateStore>(context, listen: false);
    _songs = provider.randomSong;
  }

  @override
  Widget build(BuildContext context) {
    if (_songs.length == 6) {
      return Column(children: [
        const SizedBox(height: 24),
        const Row(
          children: [
            Icon(
              Icons.electric_bolt_outlined,
              color: ColorConstants.primaryColor,
            ),
            SizedBox(width: 10),
            Text(
              'Recommended for you',
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, int index) {
              final song = _songs[index];
              final metadata = song.metadata;
              final playlist = Playlist.song(song);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(playlist: playlist),
                    ),
                  );
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: ColorConstants.boxBackgroundColor),
                    child: Row(children: [
                      CachedNetworkImage(
                          height: 50, imageUrl: metadata!.artUri.toString()),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(metadata.title,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  color: ColorConstants.darkWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          Text(metadata.artist!,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                color: ColorConstants.darkestWhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ])),
              );
            })
      ]);
    }
    return const SizedBox();
  }
}
