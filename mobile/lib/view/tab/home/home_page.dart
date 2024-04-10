import 'package:faketify/view/tab/home/widgets/recommended.dart';
import 'package:flutter/material.dart';

import 'widgets/artist.dart';
import 'widgets/your_playlist.dart';
import 'widgets/welcome_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeTitle(),
              Recommended(),
              YourPlaylist(),
              Artist(),
              SizedBox(height: 70)
            ],
          ),
        ),
      ),
    );
  }
}
