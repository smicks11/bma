// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddToDB {
  Future<void> completeProfileToDB({BuildContext context, String name, String email, String password, String phoneNum, UserCredential userCredential}) async {   
    try {
      print("Uid: ${userCredential.user.uid}");
      await FirebaseFirestore.instance.collection("UserData").doc(userCredential.user.uid).update({
        "fName": name,
        "email": email,
        "password": password,
        "PhoneNumber": phoneNum
      });
    } catch (e) {
      print(e.toString());
    }
  }
}