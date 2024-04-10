import 'package:faketify/constants/colors.dart';
import 'package:flutter/material.dart';

import '../models/playlist.dart';

class PlayingText extends StatelessWidget {
  const PlayingText({super.key, required this.playlist});

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    if (playlist.playlistId != -1) {
      return Column(
        children: [
          Text(playlist.name,
              style: const TextStyle(
                  color: ColorConstants.darkWhite,
                  fontSize: 13,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600)),
        ],
      );
    }
    return const SizedBox();
  }
}
