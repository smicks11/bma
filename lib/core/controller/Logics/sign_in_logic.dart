// // ignore_for_file: prefer_const_constructors, avoid_print

// import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
// import 'package:bma_app/views/Home/home.dart';
// import 'package:bma_app/widgets/dialog_box.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SignInLogic{
//   static void checkPwd({String password, BuildContext context}) {
//     try {
//        if(password == UserPreferences.getPwd()){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => Home()));
//     } else {
//       showSnackBar(context, "Incorrect Password");
//     }
//     } catch (e) {
//       print(e.toString());
//     }
   
//   }

//   static void showSnackBar(BuildContext context, String text) {
//     final snackBar = SnackBar(content: Text(text));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }