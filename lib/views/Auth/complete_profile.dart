// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print
import 'package:bma_app/core/controller/Database/add_to_db.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/views/Home/home.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/dialog_box.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'components/build_header_text.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

String savedPhoneNum;
String fullName;
String email;
RegExp regExp = RegExp(p);
bool obserText = true;
bool isEnabled = false;

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _CompleteProfileState extends State<CompleteProfile> {
  // final DialogBox _dialogBox = DialogBox();
  final AddToDB _addToDb = AddToDB();
  bool isEnabled;
  bool loading = false;
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullName = UserPreferences.getFullName() ?? "";
    email = UserPreferences.getEmail() ?? "";
    savedPhoneNum = UserPreferences.getPhoneNum() ?? "";
  }

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
                upperText: "Complete",
                lowerText: "your",
                spanText: "profile",
                lastText: "We want to know more about you 😍",
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: kPad, vertical: kPad - 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kPad / 2),
                      decoration: BoxDecoration(
                          color: formBoxColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kPad - 8),
                      decoration: BoxDecoration(
                          color: formBoxColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: "Re-enter Mobile No",
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            savedPhoneNum = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kPad - 8),
                      decoration: BoxDecoration(
                          color: formBoxColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 12),
                        // textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: "Email Address",
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                            if (value.isNotEmpty) {
                              isEnabled = true;
                            }
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
                        // print(UserPreferences.getUserCredentialUid());
                        setState(() {
                          loading = true;
                        });
                        await Future.delayed(Duration(seconds: 2), () {
                          _addToDb.completeProfileToDB(
                            name: fullName,
                            email: email,
                            context: context,
                            phoneNum: savedPhoneNum,
                          );
                          UserPreferences.setProfileData(
                              name: fullName,
                              email: email,
                              phoneNum: savedPhoneNum);
                          setState(() {
                            loading = false;
                          });
                          DialogBox.showAlertDialog(
                            title: "Profile completed",
                            content: "Kindly proceed",
                            context: context,
                            goTo: Home(),
                          );
                        });
                      }
                    : null,
                width: MediaQuery.of(context).size.width * 0.8,
                // color: isEnabled == true ? primaryColor : primaryColor.withOpacity(0.2),
                color: primaryColor,
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
