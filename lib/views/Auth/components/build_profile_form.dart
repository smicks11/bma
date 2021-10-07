// ignore_for_file: prefer_const_constructors

import 'package:bma_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BuildProfileForm extends StatefulWidget {
  String savedPhoneNum;
  String fullName;
  String password;
  String email;
  bool isEnabled = false;
  BuildProfileForm(
      {Key key,
      this.savedPhoneNum,
      this.fullName,
      this.password,
      this.email,
      this.isEnabled})
      : super(key: key);

  @override
  State<BuildProfileForm> createState() => _BuildProfileFormState();
}

RegExp regExp = RegExp(p);
bool obserText = true;

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _BuildProfileFormState extends State<BuildProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPad, vertical: kPad),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              labelText: "Full Name",
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            ),
            onChanged: (value) {
              setState(() {
                widget.fullName = value;
              });
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              labelText: "Re-enter Mobile No",
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            ),
            onChanged: (value) {
              setState(() {
                widget.savedPhoneNum = value;
              });
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              labelText: "Email Address",
            ),
            onChanged: (value) {
              setState(() {
                widget.email = value;
              });
            },
            validator: (value) {
              if (value == "") {
                return "Please fill Email";
              } else if (!regExp.hasMatch(value)) {
                return "Email Is Invalid";
              }
              return "";
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            // textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                if (value.length <= 8) {
                  widget.isEnabled = true;
                } else {
                  widget.isEnabled = false;
                }
                widget.password = value;
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
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
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
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
