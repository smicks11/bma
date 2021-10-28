// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:bma_app/core/controller/Database/delete_from_db.dart';
import 'package:bma_app/core/controller/Database/get_from_db.dart';
import 'package:bma_app/core/controller/Logics/add_to_cart_logic.dart';
import 'package:bma_app/core/controller/Logics/send_request.dart';
import 'package:bma_app/core/models/cart_firebase.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/views/Models/components/build_cart_block.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

AddToCart addToCart;
GetFromDb _getFromDb;
DeleteFromDb _delFromDB;

class _CartScreenState extends State<CartScreen> {
  final _sendRequest = SendRequest();
  @override
  Widget build(BuildContext context) {
    _getFromDb = Provider.of<GetFromDb>(context, listen: false);
    _delFromDB = Provider.of<DeleteFromDb>(context, listen: false);
    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder<FirebaseCart>(
            future: _getFromDb.getCartItems(context),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print("There is data in the snapshot");
                print("Number of cart $_getFromDb.getModelCartItemsLength");
                if (_getFromDb.getModelCartItemsLength == 0) {
                  // ignore: missing_required_param
                  return Center(child: CustomText(text:"No model selected yet", color: black, size: 14));
                } else {
                  return SingleChildScrollView(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _getFromDb.getModelCartItemsLength,
                        itemBuilder: (BuildContext context, int index) {
                          final item = _getFromDb.getModelCartItems[index];
                          return Dismissible(
                            key: Key(item.toString()),
                            onDismissed: (direction) async {
                              _delFromDB.delFromDB(
                                index: index,
                                context: context,
                              );
                              // addToCart.getCartModelList.removeAt(index);
                              _getFromDb.getModelCartItems.removeAt(index);
                              // addToCart.showSnackBar(
                              //     context, "This model has been removed");
                            },
                            background: Container(color: primaryColor),
                            child: BuildCartBlock(
                              name: _getFromDb.getModelCartItems[index].name,
                              location:
                                  _getFromDb.getModelCartItems[index].location,
                              image: _getFromDb.getModelCartItems[index].image,
                              index: index,
                            ),
                          );
                        }),
                    // child: BuildCartBlock(),
                  );
                }
              } else {
                print("There is no data in the snapshot!!!");
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                );
              }
            }),
        bottomNavigationBar: bottomItems());
  }

  Container bottomItems() {
    final _t = AddToCart();
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: CustomText(
                  text: "Cancel",
                  size: 16,
                  color: primaryColor,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: "Let's Negotiate",
                  press: _getFromDb.getModelCartItemsLength != 0 ? () async {
                    _sendRequest.sendRequest(
                      context: context,
                      name: _getFromDb.getModelCartItems
                          .map((e) => e.name)
                          .toList(),
                      location: _getFromDb.getModelCartItems
                          .map((e) => e.location)
                          .toList(),
                      image: _getFromDb.getModelCartItems
                          .map((e) => e.image)
                          .toList(),
                    );
                    print(
                      _getFromDb.getModelCartItemsLength,
                    );
                    print(
                     UserPreferences.getPhoneNum(),
                    );
                    print(
                     UserPreferences.getUserCredentialUid(),
                    );
                    Navigator.pushNamed(context, '/success');
                  } : null,
                  textColor: white,
                ))
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: CustomText(
        text: "Model cart",
        size: 18,
        color: black,
        weight: FontWeight.bold,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          size: 30,
        ),
        color: Colors.black54,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Image.asset(
          "assets/images/logo.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }
}
