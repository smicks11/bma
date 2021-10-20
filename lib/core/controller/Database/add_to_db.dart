// ignore_for_file: avoid_print

import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToDB {
  Future<void> completeProfileToDB(
      {BuildContext context,
      String name,
      String email,
      String phoneNum}) async {
    try {
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(UserPreferences.getUserCredentialUid())
          .set({
        "fName": name,
        "email": email,
        "PhoneNumber": phoneNum,
        "Uid": UserPreferences.getUserCredentialUid(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> selectedModelsToDatabase(
      {BuildContext context, String name, String image, String location}) async {
    try {
      await FirebaseFirestore.instance
          .collection("CartList")
          .doc(UserPreferences.getUserCredentialUid())
          .set({
        "Uid": UserPreferences.getUserCredentialUid(),
        "selectedModels": FieldValue.arrayUnion([
          {
          "name": name,
          "location": location,
          "image": image,
        },
        ]),
      },SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }



  ///Admin Methods
  Future<void> completeAdminProfileToDB(
      {BuildContext context,
      String name,
      String email,
      String phoneNum}) async {
    try {
      await FirebaseFirestore.instance
          .collection("AdminData")
          .doc(UserPreferences.getAdminCredentialUid())
          .set({
        "fName": name,
        "email": email,
        "PhoneNumber": phoneNum,
        "Uid": UserPreferences.getAdminCredentialUid(),
      });
    } catch (e) {
      print(e.toString());
    }
  }
  
  Future<void> RegisterAsAnAdmin(
      {BuildContext context,
      String phoneNum}) async {
    try {
      await FirebaseFirestore.instance
          .collection("AdminNewEntryReg")
          .doc()
          .set({
        "PhoneNumber": phoneNum,
        "RegisteredBy": UserPreferences.getAdminCredentialUid(),
      });
      showSnackBar(context, "This number has been registered as an admin!🚀");
    } catch (e) {
      print(e.toString());
    }
  }

   void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
