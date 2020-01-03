import 'package:anime_me/Networking/Network.dart';
import 'package:anime_me/Networking/UserService.dart';
import 'package:anime_me/Util/Toast.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationController{

  void shiftFocus(BuildContext context, FocusNode newFocus){
    FocusScope.of(context).requestFocus(newFocus);
  }

  bool validateSubmission(String email, String userName, String password, String reenterPassword,
      BuildContext context, List<FocusNode> nodes){
    bool toReturn = false;
    if(email.length == 0){
      //show toast
      MyToast.showToast("Email must be non-empty", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[0]);
    }else if(! EmailValidator.validate(email)){
      //show toast
      MyToast.showToast("Must use a valid email", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[0]);
    }else if(userName.length == 0){
      //show toast
      MyToast.showToast("UserName must be non-empty", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[1]);
    }else if (password.length == 0){
      //show toast
      MyToast.showToast("Password must be non-empty", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[2]);
    }else if (reenterPassword.length == 0){
      //show toast
      MyToast.showToast("Must Re Enter Password", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[3]);
    }else if(password != reenterPassword){
      //show toast
      MyToast.showToast("Passwords Do Not Match", Colors.white, Colors.red);
      // move focus
      shiftFocus(context, nodes[3]);
    }else{
      toReturn = true;
    }
    return toReturn;
  }


  void submitRegistration(String email, String userName, String password, String reenterPassword,
      BuildContext context, List<FocusNode> nodes) async{

    if(validateSubmission(email, userName, password, reenterPassword, context, nodes)){
      //must pass validation in order to continue with process
      try{
        Map<String, dynamic> authCode = await UserService.registerUser(email, userName, password);
        MyToast.showToast("Account Creation Successfull", Colors.white, Colors.blue);
        Navigator.of(context).pop(authCode);
      }on HttpError catch(e){
        //error occurred in registering user
        MyToast.showToast(e.message, Colors.white, Colors.red);
        print(e);
      }
    }
  }
}