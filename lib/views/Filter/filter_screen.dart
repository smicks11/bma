// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:bma_app/core/controller/Logics/filter_logic.dart';
import 'package:bma_app/core/data/data.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Filter/components/filter_header.dart';
import 'package:bma_app/views/Filter/filter_result.dart';
import 'package:bma_app/widgets/back_button.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isLoading = false;
  bool _isEnabled = false;
  bool _isEnabledTwo = false;
  bool _isEnabledThree = false;
  bool _isEnabledFour = false;
  FilterLogic _filterLogic;
  String selectedLocation;
  String selectedHeight;
  String selectedSkinColor;
  String selectedBodySize;
  @override
  Widget build(BuildContext context) {
    _filterLogic = Provider.of<FilterLogic>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              BackIcon(),
              FilterHeader(),
              buildDropdown(
                  title: "Select Location",
                  select: selectedLocation,
                  list: location,
                  func: (value) {
                    setState(() {
                      selectedLocation = value;
                      if (value != null) {
                        _isEnabled = true;
                      } else {
                        _isEnabled = false;
                      }
                      print(selectedLocation);
                    });
                  }),
              buildDropdown(
                  title: "Select Height",
                  select: selectedHeight,
                  list: height,
                  func: (value) {
                    setState(() {
                      selectedHeight = value;
                      if (value != null) {
                        _isEnabledTwo = true;
                      } else {
                        _isEnabledTwo = false;
                      }
                      print(selectedHeight);
                    });
                  }),
              buildDropdown(
                  title: "Select Body-Size",
                  select: selectedBodySize,
                  list: bodySize,
                  func: (value) {
                    setState(() {
                      selectedBodySize = value;
                      if (value != null) {
                        _isEnabledThree = true;
                      } else {
                        _isEnabledThree = false;
                      }
                      print(selectedBodySize);
                    });
                  }),
              buildDropdown(
                  title: "Select Skin-Color",
                  select: selectedSkinColor,
                  list: skinColor,
                  func: (value) {
                    setState(() {
                      selectedSkinColor = value;
                      if (value != null) {
                        _isEnabledFour = true;
                      } else {
                        _isEnabledFour = false;
                      }
                      print(selectedSkinColor);
                    });
                  }),
              Spacer(),
              Center(
                child: PrimaryButton(
                  text: _isLoading == true ? "Processing...." : "Continue",
                  textColor: white,
                  press: _isEnabled == true &&
                          _isEnabledTwo == true &&
                          _isEnabledThree == true &&
                          _isEnabledFour == true
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await Future.wait<void>([
                            (() async => await  _filterLogic
                              .filterLocation(param: selectedLocation))(),
                            (() async => await _filterLogic.filterHeight(param: selectedHeight))(),
                            (() async => await _filterLogic.filterSize(param: selectedBodySize))(),
                            (() async => await _filterLogic.filterColor(param: selectedSkinColor))(),
                          ]).then((value) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => FilterResult()));
                          setState(() {
                            _isLoading = false;
                          });
                          });
                        }
                      : null,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildDropdown(
      {String title, String select, List list, Function func}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad, vertical: kPad / 2),
      child: Container(
        decoration: BoxDecoration(
            color: formBoxColor, borderRadius: BorderRadius.circular(kPad)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: DropdownButton(
              isExpanded: true,
              underline: SizedBox(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: title,
                  size: 12,
                  color: Colors.black45,
                ),
              ),
              value: select,
              items: list.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: CustomText(
                    text: item,
                    size: 14,
                    color: Colors.black54,
                  ),
                );
              }).toList(),
              onChanged: func),
        ),
      ),
    );
  }
}
