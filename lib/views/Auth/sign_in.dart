// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:bma_app/core/controller/Logics/sign_in_logic.dart';
import 'package:bma_app/services/auth_service.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignInScreeen extends StatefulWidget {
  const SignInScreeen({Key key}) : super(key: key);

  @override
  _SignInScreeenState createState() => _SignInScreeenState();
}

String savedPhoneNum;
String password;
bool obserText = true;

class _SignInScreeenState extends State<SignInScreeen> {
  final AuthService _authService = AuthService();
  bool isEnabled = false;
  bool loading = false;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: kPad,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPad),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Welcome back",
                            size: 28,
                            color: black,
                          ),
                          Row(
                            children: [
                              CustomText(
                                  text: UserPreferences.getFullName()
                                      .split(" ")[0] ?? '',
                                  size: 28,
                                  color: black),
                              const SizedBox(
                                width: kPad / 5,
                              ),
                              CustomText(
                                text: UserPreferences.getFullName() == null ? "" :  "✊",
                                size: 28,
                                color: primaryColor,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildPasswordField(),
                SizedBox(
                  height: kPad,
                ),
                PrimaryButton(
                    text: "Next",
                    textColor: white,
                    press: isEnabled == true
                        ? () {
                            // SignInLogic.checkPwd(
                            //   password: password,
                            //   context: context,
                            // );
                          }
                        : null,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: isEnabled == true
                        ? primaryColor
                        : primaryColor.withOpacity(0.1)),
              ],
            )),
      ),
    );
  }

  Padding buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: kPad - 8),
        decoration: BoxDecoration(
            color: formBoxColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14)),
        child: TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 12),
          // textAlign: TextAlign.center,
          onChanged: (value) {
            setState(() {
              if (value.length >= 8) {
                isEnabled = true;
              } else {
                isEnabled = false;
              }
              password = value;
            });
          },
          obscureText: obserText,
          validator: (value) {
            if (value == "") {
              return "Please FIll Password";
            } else if (value.length < 8) {
              return "Password is too short";
            }
            return "";
          },

          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            labelText: "Password",
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obserText = !obserText;
                });
                FocusScope.of(context).unfocus();
              },
              child: Icon(
                obserText == true ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
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
