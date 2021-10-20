// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({
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
                text: "select".toUpperCase(), 
                size: 10, 
                color: black,
                letterspacing: 3.0,
                weight: FontWeight.bold,
              ),
              SizedBox(width: kPad / 4,),
              CustomText(
                text: "based on".toUpperCase(), 
                size: 10, 
                color: Colors.red,
                letterspacing: 3.0,
                weight: FontWeight.bold,
              ),
            ],
          ),
          CustomText(
                text: "Preference", 
                size: 28, 
                color: black,
                weight: FontWeight.bold,
              ),
        ],
      ),
    );
  }
}
