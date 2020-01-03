

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{


  static Future<void> setString(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<dynamic> getSingleItem(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}