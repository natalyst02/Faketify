import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import 'song.dart';

class Playlist {
  Playlist({required this.playlistId});

  Playlist.song(Song song) : songList = [song] {
    song.searchOffline();
  }

  int playlistId = -1;
  String name = "";
  Uri? artUri;
  List<Song> songList = [];

  Future<void> fetchData() async {
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/playlist-song/$playlistId';

    final response = await http.get(Uri.parse(url));
    final responseList = json.decode(utf8.decode(response.bodyBytes))['result'];

    final responseSongList = responseList['songs'];
    songList = responseSongList.map<Song>((e) => Song.fromJson(e)).toList();

    name = responseList['playlist_name'];
    artUri = Uri.parse(responseList['songs'][0]['albums'][0]['album_image']);
  }

  Future<void> remove(int userId, int songId) async {
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/$userId/delete/song-playlist?user_id=$userId&song_id=$songId&playlist_id=$playlistId';
    await http.delete(Uri.parse(url));
  }

  ConcatenatingAudioSource getPlaylist() {
    List<AudioSource> audioSourceList = [];
    for (var song in songList) {
      song.searchOffline();
      if (song.isOffline) {
        audioSourceList.add(AudioSource.file(song.url, tag: song.metadata));
      } else {
        audioSourceList
            .add(AudioSource.uri(Uri.parse(song.url), tag: song.metadata));
      }
    }

    return ConcatenatingAudioSource(children: audioSourceList);
  }
}
