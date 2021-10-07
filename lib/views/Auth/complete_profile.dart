// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:bma_app/core/controller/Database/add_to_db.dart';
import 'package:bma_app/services/auth_service.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Auth/components/build_profile_form.dart';
import 'package:bma_app/views/Home/home.dart';
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
String password;
String email;
RegExp regExp = RegExp(p);
bool obserText = true;

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _CompleteProfileState extends State<CompleteProfile> {
  final DialogBox _dialogBox = DialogBox();
  final AddToDB _addToDb = AddToDB();
  bool isEnabled;
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
                upperText: "Complete",
                lowerText: "your",
                spanText: "profile",
                lastText: "We want to know more about you 😍",
              ),
              BuildProfileForm(
                fullName: fullName,
                password: password,
                email: email,
                isEnabled: isEnabled,
                savedPhoneNum: savedPhoneNum,
              ),
              // buildPhoneField(),
              SizedBox(
                height: kPad,
              ),
              PrimaryButton(
                text: loading == true ? "Processing..." :  "Next",
                textColor: white,
                press: () {
                  setState(() {
                    loading = true;
                  });
                      Future.delayed(Duration(seconds: 2), () {
                      _addToDb.completeProfileToDB(
                          name: fullName,
                          email: email,
                          password: password,
                          context: context,
                          phoneNum: savedPhoneNum,
                      );
                      setState(() {
                        loading = false;
                      });
                      _dialogBox.showAlertDialog(
                        title: "Profile completed",
                        content: "Kindly proceed",
                        context: context,
                        goTo: Home(),
                      );
                    });
                },
                width: MediaQuery.of(context).size.width * 0.8,
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
