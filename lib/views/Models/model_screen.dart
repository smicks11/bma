// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Database/get_from_db.dart';
import 'package:bma_app/core/data/data.dart';
import 'package:bma_app/core/models/get_model_data_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Models/components/model_card.dart';
import 'package:bma_app/views/Models/model_details.dart';
import 'package:bma_app/widgets/back_button.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _getDb = GetFromDb();
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<List<ModelData>>(
          future: _getDb.getModelsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    //  childAspectRatio: 12/ 12,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: _getDb.getModelDataLength,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        //  Navigator.pushNamed(context, '/modelDetails');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ModelDetails(
                                  image: _getDb.modelData[index].image,
                                  name: _getDb.modelData[index].name,
                                  location: _getDb.modelData[index].location,
                                  height: _getDb.modelData[index].height,
                                  skinColor: _getDb.modelData[index].color,
                                  size: _getDb.modelData[index].size,
                                )));
                      },
                      child: ModelCard(
                        image: _getDb.modelData[index].image,
                        name: _getDb.modelData[index].name,
                        location: _getDb.modelData[index].location,
                        height: _getDb.modelData[index].height,
                        skinColor: _getDb.modelData[index].color,
                        size: _getDb.modelData[index].size,
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );
            }
          }),
      // body: ,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackIcon(),
      title: CustomText(text: "Models", size: 24, color: black),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.filter_list,
              size: 30,
            ),
            color: Colors.black54,
            onPressed: () => Navigator.pushNamed(context, '/filter')),
      ],
    );
  }
}
