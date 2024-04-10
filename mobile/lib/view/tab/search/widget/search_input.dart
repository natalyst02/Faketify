import 'package:faketify/view/music_player/models/song.dart';
import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

import '../searching.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key});

  final TextEditingController searchController = TextEditingController();

  Future<void> _onPressed(BuildContext context) async {
    String searchQuery = searchController.text;
    List<Song> searchedSong = await Song.searchSongs(searchQuery);
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(searchResults: searchedSong),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        TextField(
          controller: searchController,
          style: const TextStyle(color: ColorConstants.darkWhite, fontSize: 11),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorConstants.backgroundColor,
            hintText: 'Search',
            hintStyle:
                const TextStyle(color: ColorConstants.darkWhite, fontSize: 11),
            prefixIcon: IconButton(
              color: !FocusScope.of(context).isFirstFocus
                  ? ColorConstants.darkWhite
                  : ColorConstants.primaryColor,
              onPressed: () => _onPressed(context),
              icon: const Icon(Icons.search),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: ColorConstants.primaryColor)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
