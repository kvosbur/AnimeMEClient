


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

  void doLogin(String username, String password, BuildContext context,
      List<FocusNode> nodes) async{
    if(doLoginValidation(username, password, context, nodes)){
      //must pass validation to continue with login
    }
  }
}