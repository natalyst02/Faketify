import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

import 'package:faketify/view/music_player/models/playlist.dart';

class FlexibleSpaceBarWidget extends StatelessWidget {
  const FlexibleSpaceBarWidget({super.key, required this.playlist});

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
              imageUrl: playlist.artUri.toString(), fit: BoxFit.cover),
          Container(
            padding: const EdgeInsets.only(bottom: 15, left: 32),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  ColorConstants.backgroundColor,
                  Colors.transparent
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(playlist.name.toUpperCase(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                        color: ColorConstants.darkWhite,
                        fontSize: 30,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
