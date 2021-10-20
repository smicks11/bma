import 'package:bma_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton(
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
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(kPad)),
      child: FlatButton(
        onPressed: press,
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          )
        ),
      ),
    );
  }
}
