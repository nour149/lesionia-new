import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';
import 'dart:convert';

// ignore: camel_case_types
class Verify_service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
  //static String BaseUrl = 'http://192.168.114.53:7000';
  //static String BaseUrl = 'http://192.168.114.219:7000';
  static String BaseUrl = 'http://192.168.114.92:7000';
  // Verify a password
  // ignore: non_constant_identifier_names
  static Future<void> VerifyPw(String pw, BuildContext context) async {
    try {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );

      var username = await AuthService.getLoginuser();
      if (username.isEmpty) {
        await EasyLoading.dismiss();
        Fluttertoast.showToast(msg: "User not logged in");
        return;
      }

      var res = await http.post(
        Uri.parse('$BaseUrl/api/user/verif/pass/$username/$pw'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      String response = res.body.trim().toLowerCase();
      print("Response from server: '$response'");

      if (response == 'true') {
        await EasyLoading.dismiss();  // dismiss avant la navigation

        var email = await AuthService.getEmail();
        if (email.isEmpty) {
          email = "nourrachdi15@gmail.com"; // debug only
        }

        Navigator.pushReplacementNamed(context, '/changepw');
      } else {
        await EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Mot de passe incorrect",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    } catch (e) {
      await EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: "Erreur : ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



// Verify an Email
  static verifyEmail(email, context) async {
    try {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      var res = await http.get(
        Uri.parse(BaseUrl + '/free/verif_email/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        var result = await json.decode(res.body);
        if (result['result'] == "not found") {
          await EasyLoading.dismiss();
          Fluttertoast.showToast(
            msg: "Email Not Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true,
          );
        } else {
          print(result['result']);
          await AuthService.setEmail(email);
          await AuthService.setCode(result['result']);
          Navigator.pushReplacementNamed(context, '/verifycode');
          await EasyLoading.dismiss();
        }
      } else {}
    } catch (e) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Verify an OTP Code verification
  static verifyCode(code, context) async {
    try {
     // var token = await _storage.read(key: 'token');
      var res = await http.post(
        Uri.parse(BaseUrl + '/free/verif-code'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        //  'Authorization': 'Bearer $token',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/verifycode');
        await EasyLoading.dismiss();
      } else {
        await EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Email Not Found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 4,
          textColor: Colors.white,
          webBgColor: "#FF0000",
          webPosition: "center",
          fontSize: 16.0,
          webShowClose: true,
        );
      }
    } catch (e) {
  //    await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
