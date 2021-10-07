// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key key,
      @required this.text,
      @required this.press,
      this.color = primaryColor,
      this.padding = const EdgeInsets.all(kPad * 0.75),
      this.width, this.textColor
      })
      : super(key: key);

  final String text;
  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;
  final double width;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(kPad)),
      child: FlatButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
