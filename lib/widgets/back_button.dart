import 'package:bma_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        onPressed: () => Navigator.pop(context), 
        icon: Icon(Icons.clear, size: 30, color: black,)
      ),
    );
  }
}