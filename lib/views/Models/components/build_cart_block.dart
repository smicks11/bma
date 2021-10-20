// ignore_for_file: prefer_const_constructors
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildCartBlock extends StatelessWidget {
  const BuildCartBlock({
    Key key,
    this.index,
    this.name,
    this.location,
    this.image,
  }) : super(key: key);
  final String name;
  final String location;
  final String image;
  final int index;

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
            ClipRRect(
              borderRadius: BorderRadius.circular(kPad),
              child: CachedNetworkImage(
                placeholder: (context, url) => SizedBox(
                  height: 100,
                  width: 100,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey[50].withOpacity(0.6),
                  ),
                ),
                imageUrl: image,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CustomText(
                        text: name,
                        size: 15,
                        color: black,
                        weight: FontWeight.bold,
                      ),
                      CustomText(text: location, size: 12, color: Colors.black),
                    ],
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CustomText(
                        text: "Swipe to delete",
                        size: 10,
                        color: primaryColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
