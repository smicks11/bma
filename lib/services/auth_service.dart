// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, avoid_print
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bma_app/core/controller/Database/add_to_db.dart';
import 'package:bma_app/views/Auth/complete_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final AddToDB _addToDb = AddToDB();
  final storage = FlutterSecureStorage();

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {

      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int forceResnedingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  //Database Logics 
  Future<void> addNumToDB({String num, BuildContext context, UserCredential userCredential})async{
    try {
      FirebaseFirestore.instance.collection("UserData").doc(userCredential.user.uid).set({
        "PhoneNumber": num,
        "Uid": userCredential.user.uid
      });
    } catch (e) {
      print(
        e.toString()
      );
    }
  }

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

  //Db Logic Ends

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      addNumToDB(userCredential: userCredential);
      _addToDb.completeProfileToDB(userCredential: userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => CompleteProfile()),
          (route) => false);

      showSnackBar(context, "Signed In");
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "OTP is invalid");
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
