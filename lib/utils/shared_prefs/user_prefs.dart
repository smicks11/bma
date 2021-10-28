// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences _preferences;
  static const _keyFullName = 'fullName';
  static const _keyEmail = 'email';
  // static const _keyPassword = 'pwd';
  static const _keyPhoneNum = 'phoneNum';

  static const _keyCredential = 'cred';

  static const _keyAdminCredential = 'admincred';

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setProfileData({String name, String email,}) async{
    await _preferences.setString(_keyFullName, name);
    await _preferences.setString(_keyEmail, email);
    // await _preferences.setString(_keyPhoneNum, phoneNum);
  }

  static Future setUserNumber({String phoneNumber}) async{
    await _preferences.setString(_keyPhoneNum, phoneNumber);
  }

  static String getFullName() {
    return _preferences.getString(_keyFullName);
  }
  static String getEmail() {
   return  _preferences.getString(_keyEmail);
  }
  // static String getPwd() {
  //   return _preferences.getString(_keyPassword);
  // }
  static String getPhoneNum() {
    return _preferences.getString(_keyPhoneNum);
  }

  //Save User Credential To Local Storage
  static Future setUserCredential({UserCredential credential}) async{
    await _preferences.setString(_keyCredential, credential.user.uid);
  }

  static String getUserCredentialUid() {
    return _preferences.getString(_keyCredential);
  }


  //Admin Local Storage
    static Future setAdminCredential({UserCredential credential}) async{
    await _preferences.setString(_keyAdminCredential, credential.user.uid);
  }
  
  
  static String getAdminCredentialUid() {
    return _preferences.getString(_keyAdminCredential);
  }
}