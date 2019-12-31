import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast{

  static void showToast(String message, Color textColor, Color backgroundColor){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0
    );
  }
}