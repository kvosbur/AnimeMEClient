import 'dart:async';
import 'dart:convert';

import 'Network.dart';


class UserService{


  static dynamic registerUser(String email, String username, String password) async{
    Map<String,String> body = {"email": email, "username": username, "password":password};
    Map<String,dynamic> json = await Network.post("user/register", body);

    return json["authCode"];
  }
}