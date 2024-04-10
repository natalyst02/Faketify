import 'package:cached_network_image/cached_network_image.dart';
import 'package:faketify/constants/colors.dart';
import 'package:flutter/material.dart';

class MusicMetadata extends StatelessWidget {
  const MusicMetadata(
      {super.key,
      required this.title,
      required this.artist,
      required this.album,
      required this.artUri});

  final String title;
  final String artist;
  final String album;
  final Uri artUri;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(imageUrl: artUri.toString()),
            )),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    color: ColorConstants.darkWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            Text(
              artist,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                  color: ColorConstants.darkestWhite, fontSize: 16),
            ),
            Text(
              album,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                  color: ColorConstants.darkestWhite, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
