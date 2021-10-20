// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/data/data.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Admin/Auth/admin_complete_profile.dart';
import 'package:bma_app/views/Admin/Upload/components/upload_header.dart';
import 'package:bma_app/widgets/back_button.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'second_upload_data.dart';

class UploadData extends StatefulWidget {
  const UploadData({ Key key }) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}
String _name;

class _UploadDataState extends State<UploadData> {
  bool isEnabled = false;
  bool isEnabledOne = false;
  bool isEnabledTwo = false;
  bool isEnabledThree = false;
  bool isEnabledFour = false;
   String selectedLocation;
   String selectedHeight;
   String selectedSkinColor;
   String selectedBodySize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  BackIcon(),
                  UploadHeader(),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad / 2),
                     child: Container(                 
                            decoration: BoxDecoration(
                                color: formBoxColor,
                                borderRadius: BorderRadius.circular(kPad)),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                              decoration: InputDecoration(
                                border:
                                    UnderlineInputBorder(borderSide: BorderSide.none),
                                labelText: "Model first name",
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                  if(value.isEmpty){
                                    isEnabled = false;
                                  } else{
                                    isEnabled = true;
                                  }
                                });
                              },
                            ),
                          ),
                   ),
                  buildDropdown(
                    title: "Select Location",
                    select: selectedLocation,
                    list: location,
                    func: (value) {
                        setState(() {
                          selectedLocation = value;
                          print(selectedLocation);
                           if(value.isEmpty){
                                    isEnabledOne = false;
                                  } else{
                                    isEnabledOne = true;
                                  }
                        });}
                  ),
                  buildDropdown(
                    title: "Select Height",
                    select: selectedHeight,
                    list: height,
                    func: (value) {
                        setState(() {
                          selectedHeight = value;
                          print(selectedHeight);
                           if(value.isEmpty){
                                    isEnabledTwo = false;
                                  } else{
                                    isEnabledTwo = true;
                                  }
                        });}
                  ),
                  buildDropdown(
                    title: "Select Body-Size",
                    select: selectedBodySize,
                    list: bodySize,
                    func: (value) {
                        setState(() {
                          selectedBodySize = value;
                          print(selectedBodySize);
                           if(value.isEmpty){
                                    isEnabledThree = false;
                                  } else{
                                    isEnabledThree = true;
                                  }
                        });}
                  ),
                  buildDropdown(
                    title: "Select Skin-Color",
                    select: selectedSkinColor,
                    list: skinColor,
                    func: (value) {
                        setState(() {
                          selectedSkinColor = value;
                           if(value.isEmpty){
                                    isEnabledFour = false;
                                  } else{
                                    isEnabledFour = true;
                                  }
                          print(selectedSkinColor);
                        });}
                  ),
                  SizedBox(height: kPad,),
                  Center(
                    child: PrimaryButton(
                      text: "Next", 
                      textColor: white, 
                      press: isEnabled == true && isEnabledTwo == true && isEnabledThree == true && isEnabledFour == true ?
                      (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SecondUploadScreen(
                          selectedBodySize: selectedBodySize,
                          selectedHeight: selectedHeight,
                          selectedSkinColor: selectedSkinColor,
                          selectedLocation: selectedLocation,
                          modelName: _name,
                        )));
                      } : null,
                      color: isEnabled == true && isEnabledTwo == true && isEnabledThree == true && isEnabledFour == true  ? primaryColor : primaryColor.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width*0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   Padding buildDropdown({String title, String select, List list, Function func}) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad / 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: formBoxColor,
                      borderRadius: BorderRadius.circular(kPad)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 6),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: CustomText(text: title, size: 12, color: Colors.black45,),
                        ),
                        value: select,
                        items: list.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: CustomText(text: item, size: 14, color: Colors.black54,),
                          );
                        }).toList(),
                        onChanged: func
                      ),
                    ),
                  ),
                );
  }
}