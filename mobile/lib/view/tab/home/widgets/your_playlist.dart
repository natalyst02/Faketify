import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:faketify/constants/colors.dart';
import 'package:faketify/appstatestore.dart';

import '../../../music_player/models/playlist.dart';
import '../../../playlist/playlist_page.dart';

class YourPlaylist extends StatefulWidget {
  const YourPlaylist({super.key});

  @override
  State<YourPlaylist> createState() => _YourPlaylistState();
}

class _YourPlaylistState extends State<YourPlaylist> {
  late int _userId;
  final List<Map<String, dynamic>> _playlists = [];

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
    final url =
        '${dotenv.env['BACKEND_URL']}/api/v1/user/$_userId/all/playlist';

    final response = await http.get(Uri.parse(url));
    final responseList = json.decode(utf8.decode(response.bodyBytes))['result'];

    if (responseList.isNotEmpty) {
      for (int i = 0; i < min(responseList.length, 3); i++) {
        final playlistId = responseList[i]['id'];
        final playlist = Playlist(playlistId: playlistId);

        _playlists.add({
          "title": responseList[i]['name'],
          "image": responseList[i]['first_song']['album_image'],
          "color": ColorConstants.playlist[playlistId % 3],
          "playlist": playlist,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_playlists.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Your Playlists',
            style: TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _playlists.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  final playlist = _playlists[index];
                  playlist['playlist'].fetchData();
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PlaylistPage(playlist: playlist['playlist']))),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorConstants.backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, top: 15, bottom: 0),
                      margin: const EdgeInsets.all(4),
                      width: 160,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 130,
                            child: Stack(
                              children: [
                                CachedNetworkImage(imageUrl: playlist['image']),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: playlist['color']),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: playlist['color']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(playlist['title'],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                color: ColorConstants.darkWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
