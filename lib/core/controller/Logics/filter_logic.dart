// ignore_for_file: avoid_print

import 'package:bma_app/core/models/filter_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterLogic with ChangeNotifier {
  //Location
  List<FilterModels> locationModelList = [];
  FilterModels _filterModels;

  List<FilterModels> get getLocationResults {
    return locationModelList;
  }

  int get getLocationResultsLength {
    return locationModelList.length;
  }

  Future filterLocation({String param, BuildContext context}) async {
    List<FilterModels> newlocationModelList = [];
    try {
      QuerySnapshot checkModels =
          await FirebaseFirestore.instance.collection("AdminUploads").get();
      checkModels.docs.forEach((doc) {
        if (param.toLowerCase() ==
            doc['ModelLocation'].toString().toLowerCase()) {
          _filterModels = FilterModels(
            image: doc["UploadURL"],
            height: doc["ModelHeight"],
            name: doc["ModelName"],
            size: doc["ModelSize"],
            color: doc["ModelSkinColor"],
            location: doc["ModelLocation"],
          );
          newlocationModelList.add(_filterModels);

          locationModelList = newlocationModelList;
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }

    return locationModelList;
  }

  //Height
  List<HeightFilterModel> heightModelList = [];
  HeightFilterModel _heightFilterModels;

  List<HeightFilterModel> get getHeightResults {
    return heightModelList;
  }

  int get getHeightResultsLength {
    return heightModelList.length;
  }

  Future filterHeight({String param, BuildContext context}) async {
    List<HeightFilterModel> newFilterList = [];
    try {
      QuerySnapshot checkHeight =
          await FirebaseFirestore.instance.collection("AdminUploads").get();
      checkHeight.docs.forEach((doc) {
        if (param.toLowerCase() ==
            doc['ModelHeight'].toString().toLowerCase()) {
          _heightFilterModels = HeightFilterModel(
            image: doc["UploadURL"],
            height: doc["ModelHeight"],
            name: doc["ModelName"],
            size: doc["ModelSize"],
            color: doc["ModelSkinColor"],
            location: doc["ModelLocation"],
          );
          newFilterList.add(_heightFilterModels);

          heightModelList = newFilterList;
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return heightModelList;
  }

  ///Skin Color
  List<ColorFilterModel> colorModelList = [];
  ColorFilterModel _colorFilterModels;

  List<ColorFilterModel> get getColorResults {
    return colorModelList;
  }

  int get getColorResultsLength {
    return colorModelList.length;
  }

  Future filterColor({String param, BuildContext context}) async {
    List<ColorFilterModel> newColorList = [];
    try {
      QuerySnapshot checkColor =
          await FirebaseFirestore.instance.collection("AdminUploads").get();
      checkColor.docs.forEach((doc) {
        if (param.toLowerCase() ==
            doc['ModelSkinColor'].toString().toLowerCase()) {
          _colorFilterModels = ColorFilterModel(
            image: doc["UploadURL"],
            height: doc["ModelHeight"],
            name: doc["ModelName"],
            size: doc["ModelSize"],
            color: doc["ModelSkinColor"],
            location: doc["ModelLocation"],
          );
          newColorList.add(_colorFilterModels);

          colorModelList = newColorList;
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return colorModelList;
  }

  //Body Size

  List<SizeFilterModel> sizeModelList = [];
  SizeFilterModel _sizeFilterModels;

  List<SizeFilterModel> get getsizeResults {
    return sizeModelList;
  }

  int get getSizeResultsLength {
    return sizeModelList.length;
  }

  Future filterSize({String param, BuildContext context}) async {
    List<SizeFilterModel> newSizeList = [];
    try {
      QuerySnapshot checkSize =
          await FirebaseFirestore.instance.collection("AdminUploads").get();
      checkSize.docs.forEach((doc) {
        if (param.toLowerCase() == doc['ModelSize'].toString().toLowerCase()) {
          _sizeFilterModels = SizeFilterModel(
            image: doc["UploadURL"],
            height: doc["ModelHeight"],
            name: doc["ModelName"],
            size: doc["ModelSize"],
            color: doc["ModelSkinColor"],
            location: doc["ModelLocation"],
          );
          newSizeList.add(_sizeFilterModels);

          sizeModelList = newSizeList;
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return sizeModelList;
  }
}
