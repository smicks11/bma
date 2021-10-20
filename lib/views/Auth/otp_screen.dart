// ignore_for_file: avoid_print, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'package:bma_app/services/auth_service.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  final String getNumber;
  const OtpScreen({Key key, this.getNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

bool _progressLoader = false;
bool _progressLoaderTwo = false;

class _OtpScreenState extends State<OtpScreen> {
  bool isEnabled = false;
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  String verificationIdFinal = "";
  String smsCode = "";

  AuthService authClass = AuthService();
  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width * 1.0,
      fieldWidth: 50,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: primaryColor.withOpacity(0.1),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.black),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (value) {
        setState(() {
          if (value.isEmpty || value.length < 6) {
            isEnabled = false;
          } else {
            isEnabled = true;
          }
        });
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   startTimer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Enter\nOTP sent.",
                      color: black,
                      size: 34,
                      weight: FontWeight.w900,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: 'Kindly fill up /',
                            size: 18,
                            color: Colors.black38),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CustomText(
                              text: 'Go back', size: 20, color: primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: RaisedButton(
                        // color: HexColor("722F37"),
                        color: primaryColor,
                        onPressed: wait
                            ? null
                            : () async {
                                setState(() {
                                  start = 30;
                                  wait = true;
                                  buttonName = "Resend";
                                });
                                await authClass.verifyPhoneNumber(
                                    "+234 ${widget.getNumber}",
                                    context,
                                    setData);
                              },
                        child: CustomText(
                          text: "Send OTP",
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: otpField()),
                    SizedBox(
                      height: 40,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Send OTP again in ",
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                        TextSpan(
                          text: "00:$start",
                          style:
                              TextStyle(fontSize: 16, color: Colors.pinkAccent),
                        ),
                        TextSpan(
                          text: " sec ",
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: isEnabled
                            ? () async {
                                setState(() {
                                  _progressLoader = true;
                                  print("Loading Activated");
                                });
                                await Future.delayed(Duration(seconds: 2), () {
                                  authClass
                                      .signInwithPhoneNumber(
                                          verificationIdFinal, smsCode, context);
                                      // .then((value) => authClass.addNumToDB(
                                      //     num: widget.getNumber,
                                      //     context: context));

                                  // check whether the state object is in tree
                                  setState(() {
                                    _progressLoader = false;
                                    print("Loading DeActivated");
                                  });
                                });
                              }
                            : null,
                        child: _progressLoader == true
                            ? Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(white),
                                  ),
                                ),
                              )
                            : CustomText(
                                text: "Next",
                                size: 18,
                                color: Colors.white,
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
