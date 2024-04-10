import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

const List<String> searchSuggestList = [
  'Taylor Swift',
  'Post Malone',
  'NGHI',
  'Lover',
  'Sau Tấm Rèm',
  'Pop',
  "Hollywood's Bleeding",
];

class Suggest extends StatelessWidget {
  const Suggest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searchSuggestList
                .map(
                  (search) => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorConstants.boxBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        search,
                        style: const TextStyle(
                            color: ColorConstants.darkWhite,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      )),
                )
                .toList()),
      ],
    );
  }
}
