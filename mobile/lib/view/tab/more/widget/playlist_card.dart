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

class PlaylistCard extends StatefulWidget {
  const PlaylistCard({super.key});

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
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
      for (int i = 0; i < min(responseList.length, 4); i++) {
        final playlistId = responseList[i]['id'];
        final playlist = Playlist(playlistId: playlistId);

        _playlists.add({
          "title": responseList[i]['name'],
          "image": responseList[i]['first_song']['album_image'],
          "playlist": playlist,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_playlists.isNotEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _playlists.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, int index) {
                final playlist = _playlists[index];
                playlist['playlist'].fetchData();
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlaylistPage(playlist: playlist['playlist']))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 130,
                          child:
                              CachedNetworkImage(imageUrl: playlist['image'])),
                      const SizedBox(height: 10),
                      Text(playlist['title'],
                          style: const TextStyle(
                            color: ColorConstants.darkWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                );
              },
            ),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: const Text('See all',
                        style: TextStyle(
                          color: ColorConstants.darkWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )))),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
