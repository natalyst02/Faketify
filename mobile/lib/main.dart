import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'appstatestore.dart';
import 'view/get_started/get_started_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.faketify',
    androidNotificationChannelName: 'Audio Playback',
    androidNotificationOngoing: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase(
    join(await getDatabasesPath(), 'offline_music.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE offline_music(songId INTEGER PRIMARY KEY, path TEXT)',
      );
    },
    version: 1,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppStateStore()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faketify',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const GetStartedPage(),
    );
  }
}
