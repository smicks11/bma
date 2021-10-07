// import 'package:bma_app/views/Home/home.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bma_app/views/Auth/complete_profile.dart';
import 'package:bma_app/views/Auth/sign_up.dart';
import 'package:bma_app/views/OnBoarding/on_boarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:statusbarz/statusbarz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarBrightness:  Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StatusbarzCapturer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [Statusbarz.instance.observer],
        title: 'BMA',
        initialRoute: '/completeProfile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),        
        routes: {
          '/': (context) => const OnBoarding(),
          '/signUp': (context) => const SignUpScreeen(),
          '/completeProfile': (context) => const CompleteProfile(),
        },
      ),
    );
  }
}

