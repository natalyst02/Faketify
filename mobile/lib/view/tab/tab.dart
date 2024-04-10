import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:faketify/appstatestore.dart';
import 'package:faketify/constants/colors.dart';

import 'widgets/miniplayer.dart';
import 'home/home_page.dart';
import 'more/more_page.dart';
import 'search/search_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  final List _screen = [
    const HomePage(),
    const SearchPage(),
    const MorePage(),
  ];

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AppStateStore>(context, listen: false);

    _audioPlayer = provider.audioPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Stack(
        children: [
          _screen[_selectedIndex],
          StreamBuilder(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                if (processingState != ProcessingState.idle) {
                  return Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      child: const MiniPlayer());
                }
                return const SizedBox();
              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstants.primaryColor,
        unselectedItemColor: ColorConstants.darkWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        currentIndex: _selectedIndex,
        onTap: ((value) => setState(() {
              _selectedIndex = value;
            })),
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        backgroundColor: ColorConstants.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              activeIcon: Icon(Icons.more_horiz),
              label: 'More')
        ],
      ),
    );
  }
}
