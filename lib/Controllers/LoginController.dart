


import 'package:anime_me/Networking/Network.dart';
import 'package:anime_me/Networking/UserService.dart';
import 'package:anime_me/Util/SharedPreferenceHelper.dart';
import 'package:anime_me/Util/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController{

  void shiftFocus(BuildContext context, FocusNode newFocus){
    FocusScope.of(context).requestFocus(newFocus);
  }

  bool doLoginValidation(String username, String password, BuildContext context,
      List<FocusNode> nodes){
    bool toRet = false;
    if(username.length == 0){
      MyToast.showToast("Username Must Be Non-Empty", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[0]);
    }else if(password.length == 0){
      MyToast.showToast("Password Must Be Non-Empty", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[1]);
    }else{
      toRet = true;
    }
    return toRet;
  }

  Future<void> saveLoginResponse(Map<String, dynamic> response) async{
    await SharedPreferenceHelper.setString("authCode", response["authCode"]);
    await SharedPreferenceHelper.setString("adminType", response["adminType"].toString());
  }

  void successfulRegister(Map<String, dynamic> authResponse, BuildContext context) async{
    await saveLoginResponse(authResponse);
    Navigator.of(context).pushReplacementNamed("/main");
  }

  void doLogin(String username, String password, BuildContext context,
      List<FocusNode> nodes) async{
    if(doLoginValidation(username, password, context, nodes)){
      //must pass validation to continue with login
      try{
        Map<String, dynamic> response = await UserService.loginUser(username, password);
        MyToast.showToast("Account Login Successfull", Colors.white, Colors.blue);
        //save returned authCode and adminType to sharedPreferences
        await saveLoginResponse(response);
        Navigator.of(context).pushReplacementNamed("/main");
      }on HttpError catch(e){
        //error occurred in registering user
        MyToast.showToast(e.message, Colors.white, Colors.red);
        print(e);
      }
    }
  }

  void doInitialLoginCheck(BuildContext context) async{
    // check to see if authCode is in sharedPreferences or not
    bool exists = await SharedPreferenceHelper.checkSharedPref("authCode");
    if(exists){
      // do process to login user using the authcode
      String authCode = await SharedPreferenceHelper.getSingleItem("authCode");
      try{
        Map<String, dynamic> response = await UserService.loginUserWithAuth(authCode);
        print(response);
        Navigator.of(context).pushReplacementNamed("/main");
      }on HttpError catch(e){
        //error occurred in logging in user
        MyToast.showToast(e.message, Colors.white, Colors.red);
        print(e);
      }

    }
  }
}