import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

import '../login/login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/getStarted.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Millions of songs...err maybe.\nFree on Faketify. (We'll see)",
              style: TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              height: 60,
              color: ColorConstants.primaryColor,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage())),
              child: const Text(
                'Get Started',
                style: TextStyle(color: ColorConstants.darkWhite, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
