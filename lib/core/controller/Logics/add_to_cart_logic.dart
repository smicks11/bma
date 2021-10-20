// ignore_for_file: avoid_print

import 'package:bma_app/core/models/cart_model.dart';
import 'package:bma_app/utils/shared_prefs/cart_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCart with ChangeNotifier {
  List<CartModel> cartItems = [];
  CartModel cartModel;

  List<CartModel> get getCartModelList {
    return cartItems;
  }

  int get getCartModelListLength {
    return cartItems.length;
  }

  


  void getAddToCartData(
      {String name,
      String location,
      String image,
      BuildContext context,
      int index}) async {
    try {
      cartModel = CartModel(
        name: name,
        location: location,
        image: image,
      );
      cartItems.add(cartModel);
      CartPreferences.setCartList(
        carts: cartItems
      );
      // notifyListeners();
      // print(cartItems.length);
    } catch (e) {
      print(e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



