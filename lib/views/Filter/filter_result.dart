// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Logics/filter_logic.dart';
import 'package:bma_app/core/data/data.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Models/model_details.dart';
import 'package:bma_app/widgets/back_button.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/build_slider_result.dart';

class FilterResult extends StatefulWidget {
  const FilterResult({Key key}) : super(key: key);

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  FilterLogic _filterLogic;
  int index;
  @override
  Widget build(BuildContext context) {
    _filterLogic = Provider.of<FilterLogic>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackIcon(),
                  SizedBox(
                    height: kPad,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerTwo(textOne: "Location", textTwo: "Results"),
                        SizedBox(
                          height: kPad,
                        ),
                        _buildLocationSlider(),
                        SizedBox(
                          height: kPad,
                        ),
                        headerTwo(textOne: "Height", textTwo: "Results"),
                        SizedBox(
                          height: kPad,
                        ),
                        _buildHeightSlider(),
                        SizedBox(
                          height: kPad,
                        ),
                        headerTwo(textOne: "Size", textTwo: "Results"),
                        SizedBox(
                          height: kPad,
                        ),
                        _buildSizeSlider(),
                        SizedBox(
                          height: kPad,
                        ),
                        headerTwo(textOne: "Skin Color", textTwo: "Results"),
                        SizedBox(
                          height: kPad,
                        ),
                        _buildColorSlider(),
                        SizedBox(
                          height: kPad,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding headerTwo({String textOne, String textTwo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad),
      child: Row(
        children: [
          CustomText(
            text: textOne.toUpperCase(),
            size: 16,
            color: black,
            letterspacing: 3.0,
            weight: FontWeight.bold,
          ),
          SizedBox(
            width: kPad / 4,
          ),
          Text(textTwo.toUpperCase(),
              style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold))),
          Text("🔥"),
        ],
      ),
    );
  }

  Container _buildLocationSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _filterLogic.getLocationResultsLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image:_filterLogic.locationModelList[index].image,
                          name:_filterLogic.locationModelList[index].name,
                          location:_filterLogic.locationModelList[index].location,
                          height:_filterLogic.locationModelList[index].height,
                          skinColor:_filterLogic.locationModelList[index].color,
                          size:_filterLogic.locationModelList[index].size,
                        )));
              },
              child: BuildSliderResult(
                name: _filterLogic.locationModelList[index].name,
                image: _filterLogic.locationModelList[index].image,
                location: _filterLogic.locationModelList[index].location,
                index: index,
              ),
            );
          }
          ),
    );
  }

   Container _buildHeightSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _filterLogic.getHeightResultsLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image:_filterLogic.getHeightResults[index].image,
                          name:_filterLogic.getHeightResults[index].name,
                          location:_filterLogic.getHeightResults[index].location,
                          height:_filterLogic.getHeightResults[index].height,
                          skinColor:_filterLogic.getHeightResults[index].color,
                          size:_filterLogic.getHeightResults[index].size,
                        )));
              },
              child: BuildSliderResult(
                name: _filterLogic.getHeightResults[index].name,
                image: _filterLogic.getHeightResults[index].image,
                location: _filterLogic.getHeightResults[index].location,
                index: index,
              ),
            );
          }
          ),
    );
  }

  Container _buildSizeSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _filterLogic.getSizeResultsLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image:_filterLogic.getsizeResults[index].image,
                          name:_filterLogic.getsizeResults[index].name,
                          location:_filterLogic.getsizeResults[index].location,
                          height:_filterLogic.getsizeResults[index].height,
                          skinColor:_filterLogic.getsizeResults[index].color,
                          size:_filterLogic.getsizeResults[index].size,
                        )));
              },
              child: BuildSliderResult(
                name: _filterLogic.getsizeResults[index].name,
                image: _filterLogic.getsizeResults[index].image,
                location: _filterLogic.getsizeResults[index].location,
                index: index,
              ),
            );
          }
          ),
    );
  }


  Container _buildColorSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _filterLogic.getColorResultsLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image:_filterLogic.getColorResults[index].image,
                          name:_filterLogic.getColorResults[index].name,
                          location:_filterLogic.getColorResults[index].location,
                          height:_filterLogic.getColorResults[index].height,
                          skinColor:_filterLogic.getColorResults[index].color,
                          size:_filterLogic.getColorResults[index].size,
                        )));
              },
              child: BuildSliderResult(
                name: _filterLogic.getColorResults[index].name,
                image: _filterLogic.getColorResults[index].image,
                location: _filterLogic.getColorResults[index].location,
                index: index,
              ),
            );
          }
          ),
    );
  }
}
