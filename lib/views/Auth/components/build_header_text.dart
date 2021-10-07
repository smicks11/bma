import 'package:flutter/material.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';

class BuildAuthHeader extends StatelessWidget {
  final String upperText;
  final String lowerText;
  final String spanText;
  final String lastText;
  const BuildAuthHeader({
    Key key, this.upperText, this.lowerText, this.spanText, this.lastText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: upperText,
                size: 32,
                color: black,
              ),
              Row(
                children: [
                  CustomText(text: lowerText, size: 32, color: black),
                  const SizedBox(
                    width: kPad / 5,
                  ),
                  CustomText(
                    text: spanText,
                    size: 32,
                    color: primaryColor,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: kPad / 2,
              ),
              CustomText(
                text: lastText,
                size: 14,
                color: Colors.black45,
                // weight: FontWeight.bold,
              )
            ],
          ),
        ],
      ),
    );
  }
}
