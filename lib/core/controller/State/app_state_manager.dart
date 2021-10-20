import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppStateManager with ChangeNotifier{
  bool _loading = false;

  bool _initialized = false;
  
  bool _loggedIn = false;

  bool get isLoading => _loading;
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;

  Future<void> showLoader() async{
    Future.delayed(const Duration(seconds: 2, ),(){
      return _loading = true;
    });
    notifyListeners();
  }

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), (){
      _initialized = true;
    });
    notifyListeners();
  }

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _initialized = false;
    _loading = false;

    initializeApp();
    notifyListeners();
  }
}