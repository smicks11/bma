// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:bma_app/views/Filter/components/build_slider_result.dart';
// import 'package:flutter/material.dart';

// class ClientRequestDetail extends StatelessWidget {
//   final String clientEmail;
//   final String clientNumber;
//   final List modelName;
//   final List modelImage;
//   final List modelLocation;
//   final int getLength;
//   const ClientRequestDetail({ Key key, this.clientEmail, this.clientNumber, this.modelName, this.modelImage, this.modelLocation, this.getLength }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 _buildSlider(),
//               ],
//             ),
//           ],
//         )
//       ),
//     );
//   }

//    Container _buildSlider() {
//     return Container(
//       height: 250,
//       width: double.infinity,
//       child: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: getLength,
//           itemBuilder: (BuildContext context, int index) {
//             return BuildSliderResult(
//               name: modelName[index],
//               image: modelImage[index],
//               location: modelLocation[index].toString(),
//               index: index,
//             );
//           }
//           ),
//     );
//   }
// }