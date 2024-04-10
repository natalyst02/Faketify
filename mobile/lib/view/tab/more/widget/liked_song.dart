import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

import '../liked_song_page/liked_song_page.dart';

class LikedSong extends StatelessWidget {
  const LikedSong({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LikedSongPage())),
      child: const ListTile(
        contentPadding: EdgeInsets.only(left: 10),
        leading:
            Icon(Icons.favorite, color: ColorConstants.darkWhite, size: 32),
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.darkWhite,
          size: 40,
        ),
        title: Text('Liked Songs',
            style: TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
