import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class News_Service {
  static final _storage = FlutterSecureStorage();
  // Get all medical checkups
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.122.66:7000';
  //static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';
  //GET ALL NEWS
  static getallnews(context) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {

    //  var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/news'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
         // 'Authorization': 'Bearer $token',
        },
      );
      // await EasyLoading.show(
      //   status: 'loading...',
      //   maskType: EasyLoadingMaskType.black,
      // );
      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        // await EasyLoading.dismiss();
        return data;
      } else {
        // await EasyLoading.dismiss();
        print("⚠️ Aucune donnée trouvée.");
      }
    } catch (e) {
    //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// ADD POST TO DATABASE
  static saveNews(String content, BuildContext context) async {
    try {
     // var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      final msg = jsonEncode({
        "loginuser": id,
        "news_CONTENT": content,
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/news/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
       //   'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      // await EasyLoading.show(
      //   status: 'loading...',
      //   maskType: EasyLoadingMaskType.black,
      // );
      if (res.statusCode == 201) {
        // await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/news');
      } else {}
    } catch (e) {
      //await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Delete a message
  static deleteMessage(String id, BuildContext context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var res = await http.delete(
        Uri.parse(BaseUrl + '/api/news/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
       //   'Authorization': 'Bearer $token',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: 'Message successfully deleted',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
        Navigator.pushReplacementNamed(context, '/news');
      } else {
        await EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: 'There is an error !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
   //   await _storage.delete(key: 'token');
    //  Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
