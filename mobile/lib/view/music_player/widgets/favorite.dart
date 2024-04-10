import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faketify/appstatestore.dart';
import 'package:faketify/constants/colors.dart';

import '../models/song.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.song});

  final Song song;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late Song _song;
  late List<Song> _likedSongs = [];
  late int _userId;
  late bool _isFavorite = true;

  @override
  void initState() {
    super.initState();

    _song = widget.song;

    final provider = Provider.of<AppStateStore>(context, listen: false);
    _userId = provider.userId!;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _init();
      setState(() {});
    });
  }

  Future<void> _init() async {
    _likedSongs = await Song.getLikedSongs(_userId);
    _isFavorite = _likedSongs.contains(_song);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _song = widget.song;
      _isFavorite = _likedSongs.contains(_song);
    });
    return _isFavorite
        ? IconButton(
            onPressed: () async {
              await _song.removeFavorite(_userId);
              setState(() {
                _likedSongs.remove(_song);
              });
            },
            iconSize: 25,
            icon: const Icon(
              Icons.favorite,
              color: ColorConstants.primaryColor,
            ))
        : IconButton(
            onPressed: () async {
              await _song.addFavorite(_userId);
              setState(() {
                _likedSongs.add(_song);
              });
            },
            iconSize: 25,
            icon: const Icon(
              Icons.favorite_border,
              color: ColorConstants.darkestWhite,
            ));
  }
}
