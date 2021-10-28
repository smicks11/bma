// import 'package:bma_app/views/Home/home.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:bma_app/core/controller/Database/delete_from_db.dart';
import 'package:bma_app/core/controller/Database/get_from_db.dart';
import 'package:bma_app/core/controller/Logics/add_to_cart_logic.dart';
import 'package:bma_app/core/controller/Logics/filter_logic.dart';
import 'package:bma_app/utils/shared_prefs/user_prefs.dart';
import 'package:bma_app/views/Admin/Auth/admin_sign_in.dart';
import 'package:bma_app/views/Auth/auth_state.dart';
import 'package:bma_app/views/Auth/complete_profile.dart';
import 'package:bma_app/views/Auth/sign_in.dart';
import 'package:bma_app/views/Auth/sign_up.dart';
import 'package:bma_app/views/Filter/filter_screen.dart';
import 'package:bma_app/views/Home/home.dart';
import 'package:bma_app/views/Models/cart_screen.dart';
import 'package:bma_app/views/Models/model_details.dart';
import 'package:bma_app/views/Models/model_screen.dart';
import 'package:bma_app/views/OnBoarding/on_boarding.dart';
import 'package:bma_app/views/Success/thank_you_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:statusbarz/statusbarz.dart';

import 'core/controller/State/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();

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
    final _appStateManager = AppStateManager();
    final _addToCart = AddToCart();
    final _getFromDB = GetFromDb();
    final _filterLogic = FilterLogic();
    final _delFromDb = DeleteFromDb();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => _appStateManager),
        ChangeNotifierProvider(create: (ctx) => _addToCart),
        ChangeNotifierProvider(create: (ctx) => _getFromDB),
        ChangeNotifierProvider(create: (ctx) => _filterLogic),
        ChangeNotifierProvider(create: (ctx) => _delFromDb),
      ],
      child: StatusbarzCapturer(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Statusbarz.instance.observer],
          title: 'BMA',
          initialRoute: '/',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),        
          routes: {
            '/': (context) => const OnBoarding(),
            '/signUp': (context) => const SignUpScreeen(),
            '/signIn': (context) => const SignInScreeen(),
            '/completeProfile': (context) => const CompleteProfile(),
            '/filter': (context) => const FilterScreen(),
            '/models': (context) => const ModelScreen(),
            '/modelDetails': (context) => const ModelDetails(),
            '/modelCart': (context) => const CartScreen(),
            '/success': (context) => const ThankYou(),
            '/adminSignIn': (context) => const AdminSignIn(),
          },
        ),
      ),
    );
  }
}

