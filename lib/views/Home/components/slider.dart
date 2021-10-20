// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopModels extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final int index;
  const TopModels({
    Key key,
    this.image,
    this.name,
    this.location,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10),
      child: Stack(
        children: [
          Container(
            height: 250,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kPad),
              child: CachedNetworkImage(
                  placeholder: (context, url) => SizedBox(
                        height: 250,
                        width: 200,
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
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kPad),
                    bottomRight: Radius.circular(kPad)),
                shape: BoxShape.rectangle,
                color: Colors.white54,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CustomText(
                      text: name,
                      size: 14,
                      color: black,
                      weight: FontWeight.w900,
                    ),
                    CustomText(
                        text: location.toUpperCase(),
                        size: 10,
                        color: Colors.black)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
