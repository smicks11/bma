import 'package:bma_app/core/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPreferences{
 static SharedPreferences _prefernces;
 static const _keyCartList = 'cartList';

 //Set Data to Local Db
 static Future<List<CartModel>> setCartList({List carts})async{
   await _prefernces.setStringList(_keyCartList, carts);
 }

 //Get data from local DB
 static List getCartList() {
   return _prefernces.getStringList(_keyCartList);
 }
}