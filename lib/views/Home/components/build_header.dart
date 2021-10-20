// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.1,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              CustomText(
                text: "Fashion week".toUpperCase(), 
                size: 10, 
                color: black,
                letterspacing: 3.0,
                weight: FontWeight.bold,
              ),
              SizedBox(width: kPad / 4,),
              CustomText(
                text: "2021", 
                size: 10, 
                color: Colors.red,
                letterspacing: 3.0,
                weight: FontWeight.bold,
              ),
            ],
          ),
          CustomText(
                text: "Top Fashion Models", 
                size: 25, 
                color: black,
                weight: FontWeight.bold,
              ),
        ],
      ),
    );
  }
}
