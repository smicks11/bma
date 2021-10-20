// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:bma_app/core/controller/Database/get_from_db.dart';
import 'package:bma_app/core/data/data.dart';
import 'package:bma_app/core/models/recommended_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Models/cart_screen.dart';
import 'package:bma_app/views/Models/model_details.dart';
import 'package:bma_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/build_header.dart';
import 'components/build_top_rated.dart';
import 'components/menu.dart';
import 'components/slider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _getFromDb = GetFromDb();
  AnimationController _drawerSlideController;

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _drawerSlideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body:  FutureBuilder<RecommendedModel>(
        future: _getFromDb.getRecommendedModels(context),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot != null){
return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        BuildHeader(),
                        SizedBox(
                          height: kPad,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headerText(),
                              SizedBox(
                                height: kPad,
                              ),
                              buildSlider(),
                              SizedBox(
                                height: kPad,
                              ),
                              headerTwo(),
                              topRatedSection(),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              _buildDrawer()
            ],
          );
          } else{
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          }
          
        }
      ),
    );
  }

  Padding headerTwo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPad),
      child: Row(
        children: [
          CustomText(
            text: "Top".toUpperCase(),
            size: 20,
            color: black,
            letterspacing: 3.0,
            weight: FontWeight.bold,
          ),
          SizedBox(
            width: kPad / 4,
          ),
          Text("rated".toUpperCase(),
              style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold))),
          Text("🔥"),
        ],
      ),
    );
  }

  SingleChildScrollView topRatedSection() {
    return SingleChildScrollView(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image: _getFromDb.getRecData[index].image,
                          name: _getFromDb.getRecData[index].name,
                          location: _getFromDb.getRecData[index].location,
                          height: _getFromDb.getRecData[index].height,
                          skinColor: _getFromDb.getRecData[index].color,
                          size: _getFromDb.getRecData[index].size,
                        )));
              },
              child: TopRated(
                name: _getFromDb.getRecData[index].name,
                image: _getFromDb.getRecData[index].image,
                location: _getFromDb.getRecData[index].location,
                index: index,
              ),
            );
          }),
    );
  }

  Padding headerText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text("Recommended".toUpperCase(),
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold))),
    );
  }

  Container buildSlider() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _getFromDb.getRecLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ModelDetails(
                          image: _getFromDb.getRecData[index].image,
                          name: _getFromDb.getRecData[index].name,
                          location: _getFromDb.getRecData[index].location,
                          height: _getFromDb.getRecData[index].height,
                          skinColor: _getFromDb.getRecData[index].color,
                          size: _getFromDb.getRecData[index].size,
                        )));
              },
              child: TopModels(
                name: _getFromDb.getRecData[index].name,
                image: _getFromDb.getRecData[index].image,
                location: _getFromDb.getRecData[index].location,
                index: index,
              ),
            );
          }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: AnimatedBuilder(
          animation: _drawerSlideController,
          builder: (context, child) {
            return GestureDetector(
              onTap: () => _toggleDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: _isDrawerOpening() || _isDrawerOpen()
                    ? Icon(
                        Icons.clear,
                        color: Colors.black,
                      )
                    : Image.asset("assets/images/menu.png"),
              ),
            );
          }),
      actions: [
        IconButton(
            icon: Icon(
              Icons.filter_list,
              size: 26,
            ),
            color: Colors.black54,
            onPressed: () => Navigator.pushNamed(context, '/filter')),
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 20,
              color: primaryColor,
            ),
            color: Colors.black54,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => CartScreen(),))),
      ],
    );
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : Menu(),
        );
      },
    );
  }
}
