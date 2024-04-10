import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faketify/appstatestore.dart';
import 'package:faketify/constants/colors.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateStore>(context, listen: false);
    final name = provider.userName!;

    final hour = DateTime.now().hour;
    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = " morning";
    } else if (hour >= 12 && hour < 16) {
      greeting = " afternoon";
    } else if (hour >= 16 && hour < 19) {
      greeting = " evening";
    } else {
      greeting = "night";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Good$greeting, $name.",
            style: const TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal)),
        IconButton(
          onPressed: () {},
          color: ColorConstants.darkWhite,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
