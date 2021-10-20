// ignore_for_file: avoid_print
import 'package:bma_app/core/models/cart_firebase.dart';
import 'package:bma_app/core/models/get_model_data_model.dart';
import 'package:bma_app/core/models/recommended_model.dart';
import 'package:bma_app/core/models/request_history_model.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetFromDb with ChangeNotifier {
  List<SubRequestHistory> requestHistoryList = [];
  SubRequestHistory _requestHistory;

  List<SubLocation> subLocationList = [];
  SubLocation _subLocation;
  List<SubName> subNameList = [];
  SubName _subName;
  List<SubImage> subImagelist = [];
  SubImage _subImage;

  List<ModelCart> cartModel = [];
  ModelCart _modelCart;

  List<SubRec> subRec = [];
  SubRec _subRec;

  List<ModelData> modelData = [];
  ModelData _modelData;

  List<ModelCart> get getModelCartItems {
    return cartModel;
  }

  int get getModelCartItemsLength {
    return cartModel.length;
  }

  List<ModelData> get getModelData {
    return modelData;
  }

  int get getRecLength {
    return subRec.length;
  }

  List<SubRec> get getRecData {
    return subRec;
  }

  int get getModelDataLength {
    return modelData.length;
  }


   List<SubRequestHistory> get getSubRequestList {
    return requestHistoryList;
  }

  int get getSubRequestLength {
    return requestHistoryList.length;
  }

  Future<FirebaseCart> getCartItems(BuildContext context) async {
    List<ModelCart> newCartModel = [];
    List<dynamic> cartModelMap = [];
    try {
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection("CartList").get();
      cartSnapshot.docs
          .map((doc) => {
                if (doc.get("Uid") == UserPreferences.getUserCredentialUid())
                  {
                    cartModelMap = doc.get('selectedModels'),
                    cartModelMap.forEach((element) {
                      _modelCart = ModelCart(
                        name: element['name'],
                        location: element['location'],
                        image: element['image'],
                      );
                      newCartModel.add(_modelCart);

                      cartModel = newCartModel;
                    }),
                  }
              })
          .toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return FirebaseCart(cartModel: cartModel);
  }

  Future<List<ModelData>> getModelsData({BuildContext context}) async {
    List<ModelData> newModelData = [];
    try {
      QuerySnapshot modelSnapshot =
          await FirebaseFirestore.instance.collection("AdminUploads").get();
      modelSnapshot.docs.forEach((data) {
        _modelData = ModelData(
          image: data.get("UploadURL"),
          height: data.get("ModelHeight"),
          name: data.get("ModelName"),
          size: data.get("ModelSize"),
          color: data.get("ModelSkinColor"),
          location: data.get("ModelLocation"),
        );
        newModelData.add(_modelData);

        modelData = newModelData;
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return modelData;
  }

  Future<RecommendedModel> getRecommendedModels(BuildContext context) async {
    List<SubRec> newsubRecModel = [];
    List<dynamic> subRecModelMap = [];
    try {
      QuerySnapshot subRecSnapshot = await FirebaseFirestore.instance
          .collection("RecommendedModels")
          .get();
      subRecSnapshot.docs
          .map((doc) => {
                subRecModelMap = doc.get('Recommended'),
                subRecModelMap.forEach((element) {
                  _subRec = SubRec(
                    name: element['ModelName'],
                    image: element['ModelImage'],
                    height: element['ModelHeight'],
                    location: element['ModelLocation'],
                    color: element['ModelSkinColor'],
                    size: element['ModelSize'],
                  );
                  newsubRecModel.add(_subRec);

                  subRec = newsubRecModel;
                }),
              })
          .toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return RecommendedModel(recommendedModel: subRec);
  }

  ///Get Request History
  Future<RequestHistoryList> getRequestHistory(BuildContext context) async {
    List<SubRequestHistory> newSubRequestHistory = [];
    List<dynamic> requestHistoryMap = [];

    List<dynamic> nameMap = [];
    List<dynamic> locationMap = [];
    List<dynamic> imageMap = [];

    try {
      QuerySnapshot requestSnapshot =
          await FirebaseFirestore.instance.collection("ClientRequests").get();
      requestSnapshot.docs
          .map((doc) => {
                if (doc.get("Uid") == UserPreferences.getUserCredentialUid())
                  {
                    requestHistoryMap = doc.get('ClientRequestsList'),
                    requestHistoryMap.forEach((element) {
                      if (element['image'] != null &&
                          element['location'] != null &&
                          element['name'] != null) {
                        nameMap = element['name'];
                        locationMap = element['location'];
                        imageMap = element['image'];
                        _requestHistory = SubRequestHistory(
                          clientEmail: element['CLientEmail'],
                          clientName: element['ClientName'],
                          ClientNumber: element['ClientNumber'],
                          timeOfRequest: DateTime.parse(
                              element['TImeOfRequest'].toDate().toString()),
                          ModelImage: imageMap.map((imageElement) {
                            _subImage = SubImage(
                              image: imageElement,
                            );
                          }).toList(),
                          ModelLocation: locationMap.map((locationElement) {
                            _subLocation = SubLocation(
                              location: locationElement,
                            );
                          }).toList(),
                          ModelName: nameMap.map((nameElement) {
                            _subName = SubName(
                              name: nameElement,
                            );
                          }).toList(),
                        );
                        newSubRequestHistory.add(_requestHistory);

                        requestHistoryList = newSubRequestHistory;
                      }
                    }),
                  }
              })
          .toList();
          print(requestHistoryList.map((e) => e.ModelLocation.length));
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return RequestHistoryList(sub: requestHistoryList);
  }
}
