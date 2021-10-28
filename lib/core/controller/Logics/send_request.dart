// ignore_for_file: avoid_print

import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SendRequest{
  Future sendRequest({BuildContext context, List name, List image, List location}) async{
    try {
       FirebaseFirestore.instance.collection("ClientRequests").doc(UserPreferences.getUserCredentialUid()).set({
      "Uid": UserPreferences.getUserCredentialUid(),
       "ClientRequestsList": FieldValue.arrayUnion([{
         "name": name,
         "location": location,
         "image": image,
         "TImeOfRequest": DateTime.now(),
         "ClientName": UserPreferences.getFullName(),
         "ClientNumber": UserPreferences.getPhoneNum(),
         "CLientEmail": UserPreferences.getEmail(),
       }]),
    },SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
    
  }
}