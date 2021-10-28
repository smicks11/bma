// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print
import 'package:bma_app/core/controller/Database/add_to_db.dart';
import 'package:bma_app/core/controller/Logics/add_to_cart_logic.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Admin/Home/admin_home.dart';
import 'package:bma_app/views/Models/cart_screen.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/dialog_box.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

AddToCart _addToCart;

class ModelDetails extends StatefulWidget {
  final String image;
  final String name;
  final String location;
  final String height;
  final String skinColor;
  final String size;
  const ModelDetails(
      {Key key,
      this.image,
      this.name,
      this.location,
      this.height,
      this.skinColor,
      this.size})
      : super(key: key);

  @override
  State<ModelDetails> createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final AddToDB _addToDB = AddToDB();
    final DialogBox _dialogBox = DialogBox();
    _addToCart = Provider.of<AddToCart>(context, listen: false);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.image,
                fit: BoxFit.cover,
              ),
              // decoration: const BoxDecoration(
              //     // ignore: prefer_const_constructors
              // //     image: DecorationImage(
              // //   image: AssetImage("assets/"),
              // //   fit: BoxFit.cover,
              // // )
              // ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   // ignore: prefer_const_literals_to_create_immutables
              //   children: [
              //     BackButton(color: white,)
              //   ],
              // ),
            ),
            Positioned(
              top: kPad + 10,
              left: kPad - 15,
              child: BackButton(
                color: white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kPad + 10),
                        topRight: Radius.circular(kPad + 10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: kPad),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: "Model".toUpperCase(),
                                  size: 10,
                                  color: black,
                                  letterspacing: 3.0,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: kPad / 4,
                                ),
                                CustomText(
                                  text: "Details".toUpperCase(),
                                  size: 10,
                                  color: Colors.red,
                                  letterspacing: 3.0,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad),
                      //   child: Text(
                      //     widget.name,
                      //     style: GoogleFonts.amaticSc(
                      //       textStyle: TextStyle(
                      //         fontSize: 30,
                      //         color: black,
                      //         fontWeight: FontWeight.bold
                      //       )
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPad, vertical: kPad / 2),
                        child: Text(
                          "About",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Column(
                        children: [
                          modelInfo(
                              context: context,
                              parameter: "Name:",
                              desc: widget.name),
                          modelInfo(
                              context: context,
                              parameter: "Height:",
                              desc: widget.height),
                          modelInfo(
                              context: context,
                              parameter: "Skin Color:",
                              desc: widget.skinColor),
                          modelInfo(
                              context: context,
                              parameter: "Size:",
                              desc: widget.size),
                          modelInfo(
                              context: context,
                              parameter: "Location",
                              desc: widget.location),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: kPad, vertical: kPad / 2),
                      //   child: CustomText(
                      //       text: "View images", size: 20, color: primaryColor),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: kPad),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           ClipRRect(
                      //               borderRadius: BorderRadius.circular(kPad),
                      //               child: CachedNetworkImage(
                      //                 imageUrl: widget.image,
                      //                 height: 70,
                      //                 width: 70,
                      //                 fit: BoxFit.cover,
                      //               )),
                      //           ClipRRect(
                      //               borderRadius: BorderRadius.circular(kPad),
                      //               child: CachedNetworkImage(
                      //                 imageUrl:widget.image,
                      //                 height: 70,
                      //                 width: 70,
                      //                 fit: BoxFit.cover,
                      //               )),
                      //           ClipRRect(
                      //               borderRadius: BorderRadius.circular(kPad),
                      //               child: CachedNetworkImage(
                      //                 imageUrl: widget.image,
                      //                 height: 70,
                      //                 width: 70,
                      //                 fit: BoxFit.cover,
                      //               )),
                      //           ClipRRect(
                      //               borderRadius: BorderRadius.circular(kPad),
                      //               child: CachedNetworkImage(
                      //                 imageUrl: widget.image,
                      //                 height: 70,
                      //                 width: 70,
                      //                 fit: BoxFit.cover,
                      //               )),

                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Spacer(),
                      Center(
                        child: PrimaryButton(
                          text: _isLoading == true
                              ? "Processing..."
                              : "Select model".toUpperCase(),
                          textColor: white,
                          press: () {
                            setState(() {
                              _isLoading = true;
                            });
                            Future.delayed(Duration(milliseconds: 2000), () {
                              // _addToCart.getAddToCartData(
                              //   name: widget.name,
                              //   location: widget.location,
                              //   image: widget.image,
                              //   context: context,
                              // );

                              _addToDB.selectedModelsToDatabase(
                                  context: context,
                                  name: widget.name,
                                  location: widget.location,
                                  image: widget.image);
                              setState(() {
                                _isLoading = false;
                              });
                              DialogBox.showAlertDialog(
                                title: "Yay!!🤸",
                                content: "This model has been added",
                                context: context,
                                goTo: CartScreen(),
                              );
                            });
                          },
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      SizedBox(
                        height: kPad,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container modelInfo({BuildContext context, String parameter, String desc}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPad, vertical: kPad / 2),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: parameter.toUpperCase(),
            size: 14,
            color: black,
            weight: FontWeight.bold,
          ),
          CustomText(text: desc, size: 16, color: black),
        ],
      ),
    );
  }
}
