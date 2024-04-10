import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:faketify/view/music_player/models/song.dart';
import 'package:faketify/view/music_player/models/playlist.dart';

class AppStateStore with ChangeNotifier, DiagnosticableTreeMixin {
  AudioPlayer audioPlayer = AudioPlayer();
  Playlist? playlist;
  int? userId;
  String? userName;
  List<Song> randomSong = [];
}
