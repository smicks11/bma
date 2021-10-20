// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Database/add_to_db.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/views/Admin/Home/admin_home.dart';
import 'package:bma_app/views/Auth/components/build_header_text.dart';
import 'package:bma_app/widgets/dialog_box.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class RegisterAdmin extends StatefulWidget {
  const RegisterAdmin({ Key key }) : super(key: key);

  @override
  _RegisterAdminState createState() => _RegisterAdminState();
}

String _savedPhoneNum;
RegExp regExp = RegExp(p);
bool obserText = true;
bool isEnabled = false;

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _RegisterAdminState extends State<RegisterAdmin> {
  final AddToDB _addToDb = AddToDB();
  bool loading = false;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: kPad,
                width: double.infinity,
              ),
              BuildAuthHeader(
                upperText: "Register",
                lowerText: "an",
                spanText: "admin",
                lastText: "Ride on! 😍",
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: kPad, vertical: kPad - 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kPad - 8),
                      decoration: BoxDecoration(
                          color: formBoxColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: "Enter admin tel no",
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _savedPhoneNum = value;
                            if(value.isEmpty){
                              isEnabled = false;
                            } else{
                              isEnabled = true;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // buildPhoneField(),
              SizedBox(
                height: kPad,
              ),
              PrimaryButton(
                text: loading == true ? "Processing..." : "Next",
                textColor: white,
                press: isEnabled == true
                    ? () async {
                        setState(() {
                          loading = true;
                        });
                        await Future.delayed(Duration(seconds: 2), () {
                          _addToDb.RegisterAsAnAdmin(
                            context: context,
                            phoneNum: _savedPhoneNum,
                          );
                          setState(() {
                            loading = false;
                          });
                          DialogBox.showAlertDialogNoOption(
                            title: "Registered as an admin",
                            content: "Welldone🙌",
                            context: context,
                          );
                        });
                      }
                    : null,
                width: MediaQuery.of(context).size.width * 0.8,
                color: isEnabled == true ? primaryColor : primaryColor.withOpacity(0.2),
                // color: primaryColor,
              )
            ],
          )),
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