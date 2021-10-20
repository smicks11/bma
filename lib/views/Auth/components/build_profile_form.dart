// // ignore_for_file: prefer_const_constructors

// import 'package:bma_app/utils/constants.dart';
// import 'package:flutter/material.dart';

// class BuildProfileForm extends StatefulWidget {
//    String savedPhoneNum;
//    String fullName;
//    String password;
//    String email;
//   bool isEnabled = false;
//   BuildProfileForm(
//       {Key key,
//       this.savedPhoneNum,
//       this.fullName,
//       this.password,
//       this.email,
//       this.isEnabled})
//       : super(key: key);

//   @override
//   State<BuildProfileForm> createState() => _BuildProfileFormState();
// }

// RegExp regExp = RegExp(p);
// bool obserText = true;
// String savedPhoneNum;
// String fullName;
// String password;
// String email;

// String p =
//     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

// class _BuildProfileFormState extends State<BuildProfileForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: kPad, vertical: kPad / 2),
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(vertical: kPad),
//             decoration: BoxDecoration(
//                 color: formBoxColor,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(14)),
//             child: TextFormField(
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               style: TextStyle(
//                 fontSize: 12,
//               ),
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(borderSide: BorderSide.none),
//                 labelText: "Full Name",
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black54,
//                 ),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   fullName = value;
//                 });
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: kPad / 2),
//              decoration: BoxDecoration(
//                 color: formBoxColor,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(14)),
//             child: TextFormField(
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.phone,
//               style: TextStyle(
//                 fontSize: 12
//               ),
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(borderSide: BorderSide.none),
//                 labelText: "Re-enter Mobile No",
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black54,
//                 ),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   savedPhoneNum = value;
//                 });
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: kPad / 2),
//              decoration: BoxDecoration(
//                 color: formBoxColor,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(14)),
//             child: TextFormField(
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.emailAddress,
//               style: TextStyle(
//                 fontSize: 12
//               ),
//               // textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black54,
//                 ),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//                 border: UnderlineInputBorder(borderSide: BorderSide.none),
//                 labelText: "Email Address",
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   email = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == "") {
//                   return "Please fill Email";
//                 } else if (!regExp.hasMatch(value)) {
//                   return "Email Is Invalid";
//                 }
//                 return "";
//               },
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: kPad / 2),
//              decoration: BoxDecoration(
//                 color: formBoxColor,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(14)),
//             child: TextFormField(
//               textInputAction: TextInputAction.done,
//               style: TextStyle(
//                 fontSize: 12
//               ),
//               // textAlign: TextAlign.center,
//               onChanged: (value) {
//                 setState(() {
//                   if (value.length <= 8) {
//                     widget.isEnabled = true;
//                   } else {
//                     widget.isEnabled = false;
//                   }
//                   password = value;
//                 });
//               },
//               obscureText: obserText,
//               validator: (value) {
//                 if (value == "") {
//                   return "Please FIll Password";
//                 } else if (value.length < 8) {
//                   return "Password is too short";
//                 }
//                 return "";
//               },

//               decoration: InputDecoration(
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//                 border: UnderlineInputBorder(borderSide: BorderSide.none),
//                 labelText: "Password",
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       obserText = !obserText;
//                     });
//                     FocusScope.of(context).unfocus();
//                   },
//                   child: Icon(
//                     obserText == true ? Icons.visibility : Icons.visibility_off,
//                     color: Colors.black,
//                   ),
//                 ),
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
