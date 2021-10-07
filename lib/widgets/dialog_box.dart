// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox {
  void showAlertDialog(
      {BuildContext context, String title, String content, Widget goTo}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                CupertinoDialogAction(
                    textStyle: TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                CupertinoDialogAction(
                    textStyle: TextStyle(color: primaryColor),
                    isDefaultAction: true,
                    onPressed: () async {
                      // Navigator.pop(context);
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // prefs.remove('isLogin');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => goTo));
                    },
                    child: Text("Proceed")),
              ],
            ));
  }
}
