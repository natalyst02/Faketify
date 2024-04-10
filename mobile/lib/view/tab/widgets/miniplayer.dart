import 'package:cached_network_image/cached_network_image.dart';
import 'package:faketify/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:faketify/appstatestore.dart';

import '../../music_player/models/playlist.dart';
import '../../music_player/music_player.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late Playlist? _playlist;
  late AnimationController _controller;
  late AppStateStore provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<AppStateStore>(context, listen: false);

    _audioPlayer = provider.audioPlayer;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          _playlist = provider.playlist;
          final currentPos = _audioPlayer.currentIndex;
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) {
            return const SizedBox();
          }
          final metadata = state!.currentSource!.tag as MediaItem;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MusicPlayer(playlist: _playlist!, initPos: currentPos!),
                ),
              );
            },
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: ColorConstants.boxBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    height: 55,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: ClipOval(
                        child: CachedNetworkImage(
                            imageUrl: metadata.artUri.toString()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 190,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          metadata.title,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 14,
                              color: ColorConstants.darkWhite,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          metadata.artist!,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                              color: ColorConstants.darkestWhite, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: _audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (!(playing ?? false)) {
                          _controller.stop();
                          return IconButton(
                              onPressed: _audioPlayer.play,
                              iconSize: 30,
                              color: ColorConstants.darkWhite,
                              icon: const Icon(Icons.play_arrow_rounded));
                        } else if (processingState !=
                            ProcessingState.completed) {
                          _controller.repeat();
                          return IconButton(
                              onPressed: _audioPlayer.pause,
                              iconSize: 30,
                              color: ColorConstants.darkWhite,
                              icon: const Icon(Icons.pause_rounded));
                        }
                        return const Icon(
                          Icons.play_arrow_rounded,
                          size: 30,
                          color: ColorConstants.darkWhite,
                        );
                      }),
                  IconButton(
                      onPressed: _audioPlayer.stop,
                      iconSize: 30,
                      color: ColorConstants.darkWhite,
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
            ),
          );
        });
  }
}
