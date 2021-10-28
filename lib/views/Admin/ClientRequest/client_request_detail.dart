// ignore_for_file: prefer_const_literals_to_create_immutables
// import 'package:bma_app/core/models/request_history_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Filter/components/build_slider_result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientRequestDetail extends StatelessWidget {
  // final String clientEmail;
  // final String clientNumber;
  final List<dynamic> modelName;
  final List<dynamic> modelImage;
  final List<dynamic> modelLocation;
  final int getLength;
  const ClientRequestDetail(
      {Key key,
      this.modelName,
      this.modelImage,
      this.modelLocation,
      this.getLength})
      : super(key: key);

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
                  children: [
                    const SizedBox(height: kPad,),
                    headerText(),
                    const SizedBox(height: kPad,),
                    _buildSlider(),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Padding headerText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text("Model details".toUpperCase(),
          style: GoogleFonts.geo(
              textStyle: const TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                  fontWeight: FontWeight.bold))),
    );
  }

  Container _buildSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: getLength,
          itemBuilder: (BuildContext context, int index) {
            return BuildSliderResult(
              name: modelName[index],
              image: modelImage[index],
              location: modelLocation[index],
              index: index,
            );
          }),
    );
  }
}
