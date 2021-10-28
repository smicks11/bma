// ignore_for_file: avoid_print

import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteFromDb with ChangeNotifier {
  Future delFromDB({int index, BuildContext context}) async {
    List<dynamic> selectMap = [];
    try {
      final cartCollection = FirebaseFirestore.instance
          .collection("CartList")
          .doc(UserPreferences.getUserCredentialUid());
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection("CartList").get();
      cartSnapshot.docs.map((doc) {
        if (doc.get("Uid") == UserPreferences.getUserCredentialUid()) {
          print(doc.get("Uid"));
          selectMap = doc.get("selectedModels");
          print(selectMap[index]);
          cartCollection.update({
            "selectedModels": FieldValue.arrayRemove([selectMap[index]])
          });
        }
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Swipe to delete error $e");
    }
  }
}
