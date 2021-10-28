// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:bma_app/services/auth_service.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Auth/otp_screen.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/build_header_text.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({Key key}) : super(key: key);

  @override
  _SignUpScreeenState createState() => _SignUpScreeenState();
}

String savedPhoneNum;

class _SignUpScreeenState extends State<SignUpScreeen> {
  final AuthService _authService = AuthService();
  bool isEnabled = false;
  bool loading = false;
  // TextEditingController phoneController = TextEditingController();
  var controller = MaskedTextController(mask: '(000) 000-00-000');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              // height: double.infinity,
              // width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: kPad,
                    width: double.infinity,
                  ),
                  BuildAuthHeader(
                    upperText: "Enter your",
                    lowerText: "mobile",
                    spanText: "number",
                    lastText: "We will send you a confirmation code",
                  ),
                  buildPhoneField(),
                  SizedBox(
                    height: kPad * 2,
                  ),
                  PrimaryButton(
                      text: "Next",
                      textColor: white,
                      press: isEnabled == true
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => OtpScreen(
                                        getNumber: savedPhoneNum,
                                      )));
                            }
                          : null,
                      width: MediaQuery.of(context).size.width * 0.8,
                      color: isEnabled == true
                          ? primaryColor
                          : primaryColor.withOpacity(0.1)),
                ],
              )),
        ),
      ),
    );
  }

  Padding buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad),
      child: Container(
        // decoration: BoxDecoration(
        //     color: formBoxColor,
        //     shape: BoxShape.rectangle,
        //     borderRadius: BorderRadius.circular(14)),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          cursorColor: black,
          autofocus: true,
          controller: controller,
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 22, color: Colors.black),
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            hintText: "(000) 000-00-000",
            hintStyle: GoogleFonts.dmSans(
                textStyle: TextStyle(fontSize: 22, color: Colors.black26)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 0, right: 8),
              child: Text("+234",
                  style: TextStyle(fontSize: 22, color: Colors.black)),
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
