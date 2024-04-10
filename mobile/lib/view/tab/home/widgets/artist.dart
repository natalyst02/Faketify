import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faketify/constants/colors.dart';

List<Map<String, dynamic>> artists = [
  {
    'image': 'https://images2.imgbox.com/e6/f6/1V0laTql_o.jpg',
    'name': 'Taylor Swift'
  },
  {'image': 'https://images2.imgbox.com/96/17/wgqVJeAl_o.jpg', 'name': 'NGHI'},
  {
    'image': 'https://images2.imgbox.com/a3/57/rHey6XB7_o.jpg',
    'name': 'Post Malone'
  },
  {
    'image': 'https://images2.imgbox.com/71/ca/DO01qqI3_o.jpg',
    'name': 'RPT MCK'
  }
];

class Artist extends StatelessWidget {
  const Artist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Suggested Artists',
          style: TextStyle(
              color: ColorConstants.darkWhite,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: artists.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) {
                final artist = artists[index];

                return Container(
                  width: 155,
                  padding: const EdgeInsets.only(
                      right: 15, left: 15, top: 15, bottom: 0),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: ColorConstants.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 125,
                          width: 125,
                          child: ClipOval(
                            child:
                                CachedNetworkImage(imageUrl: artist['image']),
                          )),
                      const SizedBox(height: 16),
                      Text(artist['name'],
                          style: const TextStyle(
                              color: ColorConstants.darkWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
