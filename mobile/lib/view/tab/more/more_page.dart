import 'package:flutter/material.dart';

import 'widget/liked_song.dart';
import 'widget/more_title.dart';
import 'widget/playlist_card.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoreTitle(),
              PlaylistCard(),
              LikedSong(),
              // Divider(
              //     height: 5,
              //     thickness: 0.5,
              //     color: ColorConstants.darkestWhite),
              // ActivityCard(title: 'Followed Artist', icon: Icons.people),
              SizedBox(height: 70)
            ],
          ),
        ),
      ),
    );
  }
}
