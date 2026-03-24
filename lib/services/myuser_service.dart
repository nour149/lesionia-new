import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Myuser_Service {
  static final _storage = FlutterSecureStorage();

  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
 // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.114.92:7000';
  //static String BaseUrl = 'http://192.168.1.190:7000';
  // Get all Users
  static getUser(context) async {
    try {
      var username = await AuthService.getLoginuser();
     // var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/user/interrogator/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        //  'Authorization': 'Bearer $token',
        },
      );
      print(res.statusCode);

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        AuthService.setInterrogatorID(data['id_INTERROGATOR']);
        return data;
      } else {}
    } catch (e) {
    //  await _storage.delete(key: 'token');
   //   Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Get all Users by ID
  static getUserbyID(username, context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/user/interrogator/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
       //   'Authorization': 'Bearer $token',
        },
      );
      print(res.statusCode);

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        return data;
      } else {}
    } catch (e) {
   ///   await _storage.delete(key: 'token');
    //  Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Get all details about user
  static getmyUserdetail(context) async {
    try {
      var username = await AuthService.getLoginuser();
   //   var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/user/$username'),
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
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else {}
    } catch (e) {
   //   await _storage.delete(key: 'token');
    //  Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Get Email by User
  static getEmailbyUser(context) async {
    try {
      var username = await AuthService.getLoginuser();
     // var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/user/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
      //    'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        return data;
      } else {}
    } catch (e) {
      //await _storage.delete(key: 'token');
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Get Inst by User
  static getinstbyUser(context) async {
    try {
      var username = await AuthService.getLoginuser();
      //var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/user/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        //  'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        return data;
      } else {}
    } catch (e) {
  //    await _storage.delete(key: 'token');
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  static updatepw(pw, context) async {
    try {
      var id = await AuthService.getId();
    //  var token = await _storage.read(key: 'token');
      var email = await AuthService.getEmail();
      var res = await http.post(
        Uri.parse(BaseUrl + '/free/change_pw/$email/$pw'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
       //   'Authorization': 'Bearer $token',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        var result = await json.decode(res.body);
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/profile');
        Fluttertoast.showToast(
            msg: result['result'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
      } else {}
    } catch (e) {
  //    await _storage.delete(key: 'token');
  //    Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static saveNewUser(user,context)
  {


   // Uri.parse(BaseUrl)

  }



  static setNewPassword(pw, context) async {
    try {
      var email = await AuthService.getEmail();
      var res = await http.post(
        Uri.parse(BaseUrl + '/free/change_pw/$email/$pw'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/login');
        await AuthService.removeToken();
        Fluttertoast.showToast(
            msg: 'Password successfully changed !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
      } else {}
    } catch (e) {
    //  await _storage.delete(key: 'token');
     /// Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
