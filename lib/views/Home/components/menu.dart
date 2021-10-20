// ignore_for_file: avoid_print, prefer_final_fields, prefer_const_constructors

import 'package:bma_app/core/models/menu_model.dart';
import 'package:bma_app/utils/constants.dart';
import 'package:bma_app/views/Home/home.dart';
import 'package:bma_app/views/Models/model_screen.dart';
import 'package:bma_app/views/RequestHistory/request_history.dart';
import 'package:bma_app/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static List <MenuModel>_menuTitles = [
    MenuModel(
      title: "Home",
      goTo: Home(),
    ),
    MenuModel(
      title: "Reach Out",
      goTo: Home(),
    ),
    MenuModel(
      title: "Request history",
      goTo: RequestHistory(),
    ),
    MenuModel(
      title: "See models",
      goTo: ModelScreen(),
    ),
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        image: DecorationImage(
          // ignore: prefer_const_constructors
          image: AssetImage("assets/images/model_5.jpeg"),
          fit: BoxFit.cover,
        )
      ),
      // color: black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildFlutterLogo(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildFlutterLogo() {
    return Positioned(
      right: -100,
      bottom: -30,
      child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            "assets/images/logo.png",
            height: 400,
            width: 400,
          )
          // child: FlutterLogo(
          //   size: 400,
          // ),
          ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ..._buildListItems(),
        const Spacer(),
        _buildGetStartedButton(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => _menuTitles[i].goTo));
              },
              child: Text(_menuTitles[i].title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ),
        ),
      );
    }
    return listItems;
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.elasticOut.transform(
                _buttonInterval.transform(_staggeredController.value));
            final opacity = animationPercent.clamp(0.0, 1.0);
            final scale = (animationPercent * 0.5) + 0.5;

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: PrimaryButton(
            text: "Sign out".toUpperCase(), 
            press: () => FirebaseAuth.instance.signOut(), 
            textColor: white,
          ),
        ),
      ),
    );
  }
}
