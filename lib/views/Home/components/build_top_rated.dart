// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopRated extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final int index;
  const TopRated({
    Key key,
    this.image,
    this.name,
    this.location,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: kPad / 2),
      decoration: BoxDecoration(
          color: formBoxColor, borderRadius: BorderRadius.circular(kPad)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kPad),
                child: CachedNetworkImage(
                    placeholder: (context, url) => SizedBox(
                          height: 100,
                          width: 100,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[50].withOpacity(0.4),
                            highlightColor: Colors.grey[50].withOpacity(0.6),
                          ),
                        ),
                    imageUrl: image,
                    fit: BoxFit.cover),
              ),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(kPad),
              //     image: DecorationImage(
              //         image: CachedNetworkImage(
              //           imageUrl: image,
              //         ),
              //         fit: BoxFit.cover)),
            ),
            SizedBox(
              width: kPad,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        size: 15,
                        color: black,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                          text: location.toUpperCase(),
                          size: 12,
                          color: Colors.black),
                    ],
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CustomText(
                        text: "Top Rated",
                        size: 10,
                        color: Colors.black45,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 18,
                      )
                    ],
                  )
                ])
          ],
        ),
      ),
    );
  }
}
