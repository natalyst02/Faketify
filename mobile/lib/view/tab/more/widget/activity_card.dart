import 'package:flutter/material.dart';
import 'package:faketify/constants/colors.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Icon(icon, color: ColorConstants.darkWhite, size: 32),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.darkWhite,
          size: 40,
        ),
        title: Text(title,
            style: const TextStyle(
                color: ColorConstants.darkWhite,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
