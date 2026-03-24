import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  const color = const Color(0xffffeaa7);
  Fluttertoast.showToast(
      msg: message, //message to show toast
      toastLength: Toast.LENGTH_LONG, //duration for message to show
      gravity: ToastGravity.TOP, //where you want to show, top, bottom
      timeInSecForIosWeb: 5, //for iOS only
      //backgroundColor: Colors.red, //background Color for message
      textColor: Colors.black,
      backgroundColor: color, //message text color
      fontSize: 16.0 //message font size
      );
}
