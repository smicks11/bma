// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Logics/verify_admin_sign_in.dart';
// import 'package:bma_app/views/Admin/Auth/admin_otp.dart';
import 'package:bma_app/views/Auth/components/build_header_text.dart';
import 'package:flutter/material.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/primary_button.dart';

class VerifyCheck extends StatefulWidget {
  const VerifyCheck({ Key key }) : super(key: key);

  @override
  State<VerifyCheck> createState() => _VerifyCheckState();
}
String savedPhoneNum;

class _VerifyCheckState extends State<VerifyCheck> {
    final _verifyAdmin = VerifyAdmin();

    bool isEnabled = false;
    bool loading = false;
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
                BuildAuthHeader(
                  upperText: "Just a",
                  lowerText: "sec",
                  spanText: "to verify",
                  lastText: "Thanks! 🙌",
                ),
                buildPhoneField(),
                SizedBox(
                  height: kPad,
                ),
                PrimaryButton(
                    text: loading == true ? "Verifying..." : "Next",
                    textColor: white,
                    press: isEnabled == true
                        ? () async{
                          setState(() {
                            loading = true;
                          });
                          await Future.value( _verifyAdmin.SecondCheckVerification(
                            context: context,
                            phoneNum: savedPhoneNum,
                          ));
                          setState(() {
                            loading = false;
                          });
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

  Padding buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad),
      child: Container(
        decoration: BoxDecoration(
            color: formBoxColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14)),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          autofocus: true,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            hintText: "Phone Number",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+234) ",
                style: TextStyle(color: black, fontSize: 17),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              if (value.length > 9) {
                isEnabled = true;
              } else {
                isEnabled = false;
              }
              savedPhoneNum = value;
            });
          },
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