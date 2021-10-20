// ignore_for_file: prefer_const_constructors
// import 'package:adfidia_affliate/data/storiesdata.dart';
import 'package:bma_app/core/models/home_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Admin/ClientRequest/client_request.dart';
import 'package:bma_app/views/Admin/RegisterAdmins/register_admin.dart';
import 'package:bma_app/views/Admin/Upload/upload_data.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({Key key}) : super(key: key);

  @override
  _AdminhomeState createState() => _AdminhomeState();
}

List<HomeModel> image = [
  HomeModel(url: "home_2.jpeg", text: "Register an admin", goTo: RegisterAdmin() ),
  HomeModel(url: "model_5.jpeg", text: "Collate requests", goTo: ClientRequest()),
];

class _AdminhomeState extends State<Adminhome> {
  Widget _buildBoxes({String text, IconData icon, Color color}) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Icon(
            icon,
            color: white,
          ),
        ),
        SizedBox(height: 5),
        CustomText(text: text, size: 14, color: black, weight: FontWeight.w500),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Panel",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "You are welcome!".toUpperCase(),
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kPad,),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: kPad,),
                  // color: Colors.blue,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: image.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => image[itemIndex].goTo));
                          },
                          child: _buildSlider(
                              index: itemIndex,
                              image: image[itemIndex].url,
                              textOne: image[itemIndex].text),
                        );
                      }),
                ),
              ),
              SizedBox(height: kPad,),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Make Uploads",
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: Colors.grey[200]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                        text: "Upload model's details",
                        size: 13,
                        color: black,
                        weight: FontWeight.bold),
                    CustomText(
                        text: "Start now!",
                        size: 16,
                        color: black),
                    Container(
                      height: 40,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) => UploadData()));
                        },
                        child: CustomText(
                            text: "Upload their data",
                            size: 16,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({String image, String textOne, int index}) {
    return Container(
      padding: EdgeInsets.only(bottom: kPad),
      child: Stack(
        children: [
          ClipRRect(
            child: Image.asset(
              "assets/images/$image",
              height: 200,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 50,
            child: Text(
                    textOne.toUpperCase(),
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0)),
                  ),
          )
        ],
      ),
    );
  }
}















