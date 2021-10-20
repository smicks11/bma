// ignore_for_file: prefer_const_constructors

import 'package:bma_app/core/controller/Database/get_from_db.dart';
import 'package:bma_app/core/models/request_history_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key key}) : super(key: key);

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  GetFromDb _getFromDb;
  //  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<GetFromDb>(context, listen: false).getRequestHistory(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _getFromDb = Provider.of<GetFromDb>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/model_5.jpeg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 50, bottom: 0),
                                child: CustomText(
                                  text: "Request History",
                                  size: 16,
                                  color: black,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // _buildNotifications(
                              //   textOne: "You made a request for 10 models",
                              //   textTwo: "Delievered",
                              //   textThree: "20 min ago",
                              // ),
                              FutureBuilder<RequestHistoryList>(
                                future: _getFromDb.getRequestHistory(context),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData && snapshot.data != null){
                                     return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _getFromDb.getSubRequestLength,
                                    itemBuilder: (_, index) {
                                      return  _buildNotifications(
                                        index: index,
                                        textOne:
                                            "You made a request for ${_getFromDb.getSubRequestList[index].ModelName.length} models",
                                        textTwo: "Request Delivered",
                                        textThree: timeago
                                            .format(_getFromDb
                                                .getSubRequestList[index]
                                                .timeOfRequest)
                                            .toString(),
                                      );
                                    },
                                  );
                                  }else if(snapshot.connectionState == ConnectionState.waiting){
                                     return Center(
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: primaryColor,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(child: CustomText(text: "No request has been made", size: 14, color: black));
                                  }
                                 
                                }
                              )
                            ],
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }

  Widget _buildNotifications(
      {String textOne,
      String textTwo,
      String textThree,
      String textFour,
      int index}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPad / 4, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      child: Text("🚀")),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: textOne,
                      size: 14,
                      color: primaryColor,
                      // weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: textTwo,
                      size: 10,
                      color: Colors.black26,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomText(
                  text: textThree,
                  size: 12,
                  color: primaryColor,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
