import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

import '../../music_player/models/playlist.dart';
import 'flexible_app_bar_widget.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({super.key, required this.playlist});

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: ColorConstants.darkWhite,
        ),
      ),
      stretch: false,
      snap: true,
      floating: true,
      surfaceTintColor: ColorConstants.backgroundColor,
      backgroundColor: ColorConstants.backgroundColor,
      expandedHeight: 350,
      elevation: 1,
      pinned: true,
      titleSpacing: 16,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          color: ColorConstants.darkWhite,
          icon: const Icon(Icons.more_vert),
        )
      ],
      flexibleSpace: FlexibleSpaceBarWidget(playlist: playlist),
    );
  }
}
