// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';
import 'dart:io';

import 'package:bma_app/services/firebase_api.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/views/Admin/Home/admin_home.dart';
import 'package:bma_app/widgets/back_button.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SecondUploadScreen extends StatefulWidget {
  final String modelName;
  final String selectedLocation;
  final String selectedHeight;
  final String selectedBodySize;
  final String selectedSkinColor;
  const SecondUploadScreen(
      {Key key,
      this.modelName,
      this.selectedLocation,
      this.selectedHeight,
      this.selectedBodySize,
      this.selectedSkinColor})
      : super(key: key);

  @override
  _SecondUploadScreenState createState() => _SecondUploadScreenState();
}

class _SecondUploadScreenState extends State<SecondUploadScreen> {
  UploadTask task;
  int index;
  File file;

  bool loading = false;
  int start = 0;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No File Selected';
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackIcon(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: kPad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: "upload".toUpperCase(),
                            size: 10,
                            color: black,
                            letterspacing: 3.0,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: kPad / 4,
                          ),
                          CustomText(
                            text: "model".toUpperCase(),
                            size: 10,
                            color: Colors.red,
                            letterspacing: 3.0,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      CustomText(
                        text: "image",
                        size: 28,
                        color: black,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                UploadBox(
                  context: context,
                  textOne: "Upload model image here",
                  textTwo: "Select image",
                  func: () => selectFile(),
                ),
                // UploadBox(
                //   context: context,
                //   textOne: "Upload the details here",
                //   textTwo: "Select image two",
                //   func: () => selectFile(),
                // ),
                // UploadBox(
                //   context: context,
                //   textOne: "Upload the details here",
                //   textTwo: "Select image three",
                //   func: () => selectFile(),
                // ),
                // UploadBox(
                //   context: context,
                //   textOne: "Upload the details here",
                //   textTwo: "Select image four",
                //   func: () => selectFile(),
                // ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.symmetric(horizontal: kPad),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.grey[200]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.preview,
                              size: 100,
                              color: Colors.teal,
                            ),
                            CustomText(
                                text: "File Preview", size: 22, color: black),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              fileName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                                const onsec = Duration(seconds: 1);
                                Timer.periodic(onsec, (timer) {
                                  if (start == 3) {
                                    setState(() {
                                      timer.cancel();
                                      loading = false;
                                    });
                                  } else {
                                    setState(() {
                                      start++;
                                    });
                                  }
                                });
                              });
                              uploadFile(
                                context: context,
                              ).then((value) => showAlertDialog(context));
                              
                            },
                            // onPressed: () {
                            //   // uploadFile(index)
                            //   // print(e.fullName);
                            // },
                            child: loading == true
                                ? CustomText(
                                    text: "PROCESSING...",
                                    size: 18,
                                    color: white)
                                : CustomText(
                                    text: "SUBMIT",
                                    size: 18,
                                    color: Colors.white),
                          )
                        ]),
                      ),
                      SizedBox(height: 20),
                      task != null ? buildUploadStatus(task) : Container(),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Container UploadBox(
      {BuildContext context,
      String textOne,
      String textTwo,
      VoidCallback func}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal: kPad),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey[200]),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 20,
                  color: Colors.teal,
                ),
                CustomText(text: textOne, size: 14, color: black),
                SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: func,
                  child:
                      CustomText(text: textTwo, size: 14, color: primaryColor),
                ),
                // PrimaryButton(
                //   press: () => selectFile(),
                //   text: "Select Image One",
                //   textColor: white,
                //   width: MediaQuery.of(context).size.width*0.8,
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("Yayy!"),
              content: Text("Model details has been uploaded"),
              actions: <Widget>[
                CupertinoDialogAction(
                    textStyle: TextStyle(color: primaryColor),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => Adminhome()));
                    },
                    child: Text("Thanks")),
              ],
            ));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  Future<void> uploadFile({String name, BuildContext context}) async {
    try {
      if (file == null) return;

      final fileName = basename(file.path);
      final destination = 'files/$fileName';

      task = FirebaseApi.uploadFile(destination, file);
      setState(() {});

      if (task == null) return;

      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');

      FirebaseFirestore.instance.collection("AdminUploads").doc().set({
        "ModelName": widget.modelName,
        "ModelSize": widget.selectedBodySize,
        "ModelLocation": widget.selectedLocation,
        "ModelHeight": widget.selectedHeight,
        "ModelSkinColor": widget.selectedSkinColor,
        "UploadURL": urlDownload,
        "UploadTime": DateTime.now(),
        "UploadedBy": UserPreferences.getAdminCredentialUid(),
        // "UploadDetails": FieldValue.arrayUnion([{
        //   "UploadURL": urlDownload,
        //   "time" : DateTime.now(),
        //   "Uid": FirebaseAuth.instance.currentUser.uid,
        // }
        // ])
      }).then((value) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            backgroundColor: primaryColor,
            message: "Uploaded Successfully",
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %\nUpload Successful',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
