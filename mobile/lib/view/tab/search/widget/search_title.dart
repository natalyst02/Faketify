import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Search",
            style: TextStyle(
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
