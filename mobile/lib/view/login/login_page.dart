import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:faketify/constants/colors.dart';
import 'package:faketify/appstatestore.dart';

import '../music_player/models/song.dart';
import '../tab/tab.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _textFieldFocusNode = FocusNode();
  bool _obscured = true;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AppStateStore>(context, listen: false);

    List<Song> songList = [];
    List<int> numberList = [];
    Random random = Random();
    while (songList.length < 6) {
      int randomNumber = random.nextInt(30);
      if (!numberList.contains(randomNumber)) {
        numberList.add(randomNumber);
        final song = Song(randomNumber);
        song.fetchMetadata();
        songList.add(song);
      }
    }
    provider.randomSong = songList;
  }

  void _toggleObscured() => setState(() {
        _obscured = !_obscured;
        if (_textFieldFocusNode.hasPrimaryFocus) {
          return;
        }
        _textFieldFocusNode.canRequestFocus = false;
      });

  Future<void> _onPressed(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final provider = Provider.of<AppStateStore>(context, listen: false);

    final url = '${dotenv.env['BACKEND_URL']}/api/v1/user/login';
    Map data = {
      'username': username,
      'password': password,
    };
    final body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    final responseList = json.decode(utf8.decode(response.bodyBytes))['result'];
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      provider.userId = responseList['user_id'];
      provider.userName = responseList['username'];
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Tabs()));
      }
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login failed'),
          icon: const Icon(
            Icons.error,
            color: ColorConstants.errorColor,
            size: 50,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Invalid username or password.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Dismiss'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(610),
                      bottomLeft: Radius.circular(60),
                    )),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          color: ColorConstants.darkWhite,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        margin: const EdgeInsets.only(
                            top: 100, left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  filled: true,
                                  fillColor: ColorConstants.darkWhite,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                obscureText: _obscured,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  filled: true,
                                  fillColor: ColorConstants.darkWhite,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(
                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            MaterialButton(
                              onPressed: () => _onPressed(context),
                              height: 40,
                              color: ColorConstants.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(
                                    color: ColorConstants.darkWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: ColorConstants.darkWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Sign up now',
                            style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
