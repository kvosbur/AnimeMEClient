import 'dart:async';
import 'dart:convert';

import 'Network.dart';


class UserService{


  static Future<Map<String,dynamic>> registerUser(String email, String username, String password) async{
    Map<String,String> body = {"email": email, "username": username, "password":password};
    Map<String,dynamic> json = await Network.post("user/register", body);

    return json;
  }

  static Future<Map<String,dynamic>> loginUser(String username, String password) async{
    Map<String,String> body = {"username": username, "password":password};
    Map<String,dynamic> json = await Network.post("user/login", body);

    return json;
  }
}