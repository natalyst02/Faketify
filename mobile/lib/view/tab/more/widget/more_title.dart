import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

class MoreTitle extends StatelessWidget {
  const MoreTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Your Library',
            style: TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal)),
        IconButton(
          onPressed: () => {},
          color: ColorConstants.darkWhite,
          icon: const Icon(Icons.person_sharp),
        ),
      ],
    );
  }
}
