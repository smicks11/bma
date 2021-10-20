// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Logics/send_request.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Home/home.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sendRequest = SendRequest();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kPad + 10),
                    topRight: Radius.circular(kPad + 10),
                  )),
              child: FutureBuilder<void>(
                  future: Future.delayed(Duration(milliseconds: 2000), () {
                    _sendRequest.sendRequest(context: context);
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Spacer(),
                          CustomText(
                              text: "We'll contact you shortly",
                              size: 20,
                              color: black),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/success.png"))),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Your request has been sent to the appropriate desk",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black38,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          PrimaryButton(
                            text: "Done",
                            press: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) => Home()));
                            },
                            width: MediaQuery.of(context).size.width * 0.3,
                            textColor: white,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(kPad * 2),
                          //   child: Image.asset("assets/images/success.png"),
                          // ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
