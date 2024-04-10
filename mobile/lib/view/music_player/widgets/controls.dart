import 'package:faketify/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song.dart';

class Controls extends StatefulWidget {
  const Controls({super.key, required this.audioPlayer, required this.song});

  final AudioPlayer audioPlayer;
  final Song song;

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  late AudioPlayer _audioPlayer;
  late Song _song;

  @override
  void initState() {
    super.initState();

    _audioPlayer = widget.audioPlayer;
    _song = widget.song;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _init();
      setState(() {});
    });
  }

  Future<void> _init() async {
    _song.searchOffline();
  }

  @override
  Widget build(BuildContext context) {
    var isOffline = _song.isOffline;
    setState(() {
      _song = widget.song;
      isOffline = _song.isOffline;
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        isOffline
            ? IconButton(
                onPressed: () {},
                color: ColorConstants.primaryColor,
                iconSize: 30,
                icon: const Icon(Icons.download_done_rounded),
              )
            : IconButton(
                onPressed: () async {
                  await _song.download();
                  setState(() {
                    isOffline = _song.isOffline;
                  });
                },
                color: ColorConstants.darkWhite,
                iconSize: 30,
                icon: const Icon(Icons.download),
              ),
        IconButton(
          onPressed: _audioPlayer.seekToPrevious,
          color: ColorConstants.darkWhite,
          iconSize: 60,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder(
            stream: _audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                    onPressed: _audioPlayer.play,
                    color: ColorConstants.darkWhite,
                    iconSize: 80,
                    icon: const Icon(Icons.play_arrow_rounded));
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                    onPressed: _audioPlayer.pause,
                    color: ColorConstants.darkWhite,
                    iconSize: 80,
                    icon: const Icon(Icons.pause_rounded));
              }
              return IconButton(
                  onPressed: () =>
                      {_audioPlayer.seek(Duration.zero), _audioPlayer.play()},
                  color: ColorConstants.darkWhite,
                  iconSize: 80,
                  icon: const Icon(Icons.play_arrow_rounded));
            }),
        IconButton(
          onPressed: _audioPlayer.seekToNext,
          color: ColorConstants.darkWhite,
          iconSize: 60,
          icon: const Icon(Icons.skip_next_rounded),
        ),
        StreamBuilder(
            stream: _audioPlayer.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              final icons = [
                const Icon(Icons.repeat_rounded,
                    color: ColorConstants.darkestWhite),
                const Icon(Icons.repeat_rounded,
                    color: ColorConstants.primaryColor),
                const Icon(Icons.repeat_one_rounded,
                    color: ColorConstants.primaryColor),
              ];
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);
              return IconButton(
                onPressed: () {
                  _audioPlayer.setLoopMode(cycleModes[
                      (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                },
                iconSize: 30,
                icon: icons[index],
              );
            })
      ],
    );
  }
}
