import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Song {
  Song(this.songId)
      : url = '${dotenv.env['BACKEND_URL']}/api/v1/user/play-song/$songId';

  Song.fromJson(Map<String, dynamic> json)
      : songId = json['song_id'],
        url =
            "${dotenv.env['BACKEND_URL']}/api/v1/user/play-song/${json['song_id']}",
        metadata = MediaItem(
          id: "$json['song_id']",
          title: json['song_name'],
          artist: json['artist_name'],
          album: json['albums'][0]['album_name'],
          artUri: Uri.parse(json['albums'][0]['album_image']),
        );

  final int songId;
  late String url;
  late MediaItem? metadata;
  bool isOffline = false;

  @override
  bool operator ==(Object other) => other is Song && songId == other.songId;

  @override
  int get hashCode => Object.hash(songId, url, metadata);

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'path': url,
    };
  }

  @override
  String toString() {
    return 'Song{songId: $songId, path: $url}';
  }

  Future<void> fetchMetadata() async {
    final url = '${dotenv.env['BACKEND_URL']}/api/v1/user/detail-song/$songId';

    final response = await http.get(Uri.parse(url));
    final responseList = jsonDecode(utf8.decode(response.bodyBytes))['result'];

    metadata = MediaItem(
      id: "$songId",
      title: responseList['song_name'],
      artist: responseList['artist_name'],
      album: responseList['albums'][0]['album_name'],
      artUri: Uri.parse(responseList['albums'][0]['album_image']),
    );
  }

  static Future<List<Song>> searchSongs(String query) async {
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/search-song?key=$query';

    final response = await http.get(Uri.parse(url));
    final responseList = json.decode(utf8.decode(response.bodyBytes))['result'];

    if (responseList.isNotEmpty) {
      List<Song> searchResults =
          responseList.map<Song>((e) => Song.fromJson(e)).toList();
      return searchResults;
    }
    return [];
  }

  static Future<List<Song>> getLikedSongs(int userId) async {
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/$userId/favourite-song';

    final response = await http.get(Uri.parse(url));
    final responseList = json.decode(utf8.decode(response.bodyBytes))['result'];

    if (responseList.isNotEmpty) {
      List<Song> searchResults =
          responseList.map<Song>((e) => Song.fromJson(e)).toList();
      return searchResults;
    }
    return [];
  }

  Future<void> addFavorite(int userId) async {
    final url = '${dotenv.env['BACKEND_URL']}/api/v1/user/add-favourite/';
    Map data = {'user_id': userId, 'song_id': songId};
    final body = json.encode(data);

    await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  Future<void> removeFavorite(int userId) async {
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/remove-favourite?user_id=$userId&song_id=$songId';
    await http.delete(Uri.parse(url));
  }

  Future<void> download() async {
    Dio dio = Dio();

    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path, "$songId.mp3");
    await dio.download(url, path);
    url = Uri.file(path).toString();
    isOffline = true;
    print('download complete');

    final db =
        await openDatabase(join(await getDatabasesPath(), 'offline_music.db'));
    await db.insert('offline_music', toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> searchOffline() async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'offline_music.db'));
    final List<Map<String, dynamic>> maps = await db.query('offline_music');
    List<int> offlineSongs = List.generate(maps.length, (i) {
      return maps[i]['songId'];
    });
    if (offlineSongs.contains(songId)) {
      isOffline = true;
      var dir = await getApplicationDocumentsDirectory();
      url = join(dir.path, "$songId.mp3");
    }
  }
}
