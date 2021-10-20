// ignore_for_file: avoid_print

import 'package:bma_app/views/Admin/Auth/admin_otp.dart';
import 'package:bma_app/views/Admin/Home/admin_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyAdmin{
   Future VerifyAdminSignIn({String phoneNum, BuildContext context}) async{
     List verify = [];
      try {
        QuerySnapshot verifySnapshot = await FirebaseFirestore.instance.collection("AdminNewEntryReg").get();
        verify = verifySnapshot.docs.map((doc) {
          if(phoneNum == doc.get("PhoneNumber")){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AdminOTP(getNumber: phoneNum,)));
            showSnackBar(context, "You are verified as an admin");
          } else{
            showSnackBar(context, "Oops.. You are not registered as an admin");
          }
        }).toList();
      } catch (e) {
        print(e.toString());
      }
      return verify;
  }
   Future SecondCheckVerification({String phoneNum, BuildContext context}) async{
     List secondVerify = [];
      try {
        QuerySnapshot verifySnapshot = await FirebaseFirestore.instance.collection("AdminNewEntryReg").get();
        secondVerify = verifySnapshot.docs.map((doc) {
          if(phoneNum != doc.get("PhoneNumber")){
            showSnackBar(context, "Oops.. You are not registered as an admin");
          } else{
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const Adminhome()));
            showSnackBar(context, "You are verified as an admin");
          }
        }).toList();
      } catch (e) {
        print(e.toString());
      }
      
      return secondVerify;
  }

   void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}