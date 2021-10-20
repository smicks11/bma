// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ModelCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String height;
  final String skinColor;
  final String size;
  final int index;
  const ModelCard({
    Key key,
    this.image,
    this.name,
    this.location,
    this.index,
    this.height,
    this.skinColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width*0.5,
          child: ClipRRect(
            child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white54,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    text: location.toUpperCase(), size: 10, color: Colors.black)
              ],
            ),
          ),
        )
      ],
    );
  }
}
