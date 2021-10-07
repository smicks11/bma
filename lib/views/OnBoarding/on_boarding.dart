// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 50,
                            width: 50,
                          ),
                          CustomText(
                            text: "BMA E-Agency",
                            size: 14,
                            color: black,
                            weight: FontWeight.w800,
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPad),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "The best",
                          size: 32,
                          color: black,
                        ),
                        Row(
                          children: const [
                            CustomText(text: "world", size: 32, color: black),
                            SizedBox(
                              width: kPad / 5,
                            ),
                            CustomText(
                              text: "models.",
                              size: 32,
                              color: primaryColor,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kPad / 2,
                        ),
                        CustomText(
                          text: "See the great personalities of our models.",
                          size: 14,
                          color: Colors.black45,                        
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/onBoard.png",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryButton(
                    text: "Sign in",
                    textColor: primaryColor,
                    press: () {},
                    color: primaryColor.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  PrimaryButton(
                    text: "Sign up",
                    textColor: white,
                    press: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ],
              ),
              SizedBox(height: kPad,),
              TextButton(onPressed: (){}, child: CustomText(text: "Sign in as an admin", size: 14, color: primaryColor))
            ],
          ),
        ),
      ),
    );
  }
}
