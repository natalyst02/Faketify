import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:faketify/constants/colors.dart';
import 'package:faketify/view/music_player/widgets/favorite.dart';

import 'package:faketify/appstatestore.dart';
import 'models/playlist.dart';
import 'models/position_data.dart';
import 'widgets/music_metadata.dart';
import 'widgets/controls.dart';
import 'widgets/playing_text.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    super.key,
    required this.playlist,
    this.initPos = 0,
  });

  final Playlist playlist;
  final int initPos;

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  late Playlist _playlist;
  late int _initPos;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();

    _playlist = widget.playlist;
    _initPos = widget.initPos;

    final provider = Provider.of<AppStateStore>(context, listen: false);

    _audioPlayer = provider.audioPlayer;
    final currentPlaylist = provider.playlist;
    final currentPos = _audioPlayer.currentIndex;

    if (currentPlaylist != _playlist ||
        currentPlaylist == null ||
        _initPos != currentPos) {
      provider.playlist = _playlist;
      _init();
    } else if (currentPlaylist == _playlist && !_audioPlayer.playing) {
      _audioPlayer.play();
    }
  }

  Future<void> _init() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }

    final audioSource = _playlist.getPlaylist();
    await _audioPlayer.setAudioSource(audioSource, initialIndex: _initPos);
    await _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorConstants.boxBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstants.boxBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: ColorConstants.darkWhite,
          iconSize: 35,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        title: PlayingText(playlist: _playlist),
        actions: [
          IconButton(
            onPressed: () {},
            color: ColorConstants.darkWhite,
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  final metadata = state!.currentSource!.tag as MediaItem;
                  return MusicMetadata(
                      title: metadata.title,
                      artist: metadata.artist ?? "",
                      album: metadata.album ?? "",
                      artUri: metadata.artUri ?? Uri.parse(""));
                }),
            Column(
              children: [
                StreamBuilder(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return ProgressBar(
                        barHeight: 2,
                        baseBarColor: ColorConstants.darkestWhite,
                        bufferedBarColor: ColorConstants.darkerWhite,
                        progressBarColor: ColorConstants.darkWhite,
                        thumbColor: ColorConstants.darkWhite,
                        timeLabelTextStyle: const TextStyle(
                            color: ColorConstants.darkWhite, fontSize: 12),
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,
                      );
                    }),
              ],
            ),
            StreamBuilder(
                stream: _audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  final index = snapshot.data!;
                  return Controls(
                      audioPlayer: _audioPlayer,
                      song: _playlist.songList[index]);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //     onPressed: () {},
                //     color: ColorConstants.primaryColor,
                //     iconSize: 25,
                //     icon: const Icon(Icons.headphones)),
                // Expanded(
                //     child: Text(
                //   "AirPods Pro",
                //   style: TextStyle(
                //       color: ColorConstants.primaryColor,
                //       letterSpacing: 0.8,
                //       fontSize: 10),
                // )),
                const SizedBox(width: 10),
                StreamBuilder(
                    stream: _audioPlayer.currentIndexStream,
                    builder: (context, snapshot) {
                      final index = snapshot.data!;
                      return Expanded(
                        child: Text(
                          "${index + 1}/${_playlist.songList.length}",
                          style: const TextStyle(
                              color: ColorConstants.darkestWhite, fontSize: 16),
                        ),
                      );
                    }),
                StreamBuilder(
                    stream: _audioPlayer.currentIndexStream,
                    builder: (context, snapshot) {
                      final index = snapshot.data!;
                      return FavoriteButton(song: _playlist.songList[index]);
                    }),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {},
                    color: ColorConstants.darkestWhite,
                    iconSize: 25,
                    icon: const Icon(Icons.menu))
              ],
            ),
            const SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
