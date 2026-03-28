import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:http/http.dart' as http;

class Stats {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
 // static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.122.66:7000';
 // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';
  static getdatemed(context) async {
    try {
   ///   var token = await _storage.read(key: 'token');
      var id = await AuthService.getId();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/stats/date_checkup/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
       ///   'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        return data;
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        print('no content available');
      }
    } catch (e) {
    ///  await _storage.delete(key: 'token');
   ///   Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // static getalltreatmentsbyid(context) async {
  //   try {
  //     var token = await _storage.read(key: 'token');
  //     var id = await AuthService.getId();
  //     var res = await http.get(
  //       Uri.parse(BaseUrl + '/api/treatmenthistory/alltreatments/$id'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (res.statusCode == 200) {
  //       var data = await json.decode(res.body);
  //       await EasyLoading.dismiss();
  //       return data;
  //     } else if (res.statusCode == 204) {
  //       await EasyLoading.dismiss();
  //       var empty = ['no content'];
  //       print('no content available');
  //       return empty;
  //     } else {
  //       print("Error");
  //     }
  //   } catch (e) {
  //     await _storage.delete(key: 'token');
  //     Navigator.pushReplacementNamed(context, '/login');
  //   }
  // }

  static getallcheckupsbyid(context) async {
    try {
   ///   var token = await _storage.read(key: 'token');
      String username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/medical_checkup/allcheckups/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        ///  'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else if (res.statusCode == 204) {
        await EasyLoading.dismiss();
        var empty = ['no content'];
        print('no content available');
        return empty;
      } else {
        print("Error");
      }
    } catch (e) {
   ///   await _storage.delete(key: 'token');
     /// Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static getalltravelsbyid(context) async {
    try {
    ///  var token = await _storage.read(key: 'token');
      var username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/travel_residency/gettravels/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
       ///   'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else if (res.statusCode == 204) {
        await EasyLoading.dismiss();
        var empty = ['no content'];
        print('no content available');
        return empty;
      } else {
        print("Error");
      }
    } catch (e) {
////await _storage.delete(key: 'token');
    ////   Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static getallsamplesbyid(context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/sample/getsamples/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
     ///     'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else if (res.statusCode == 204) {
        await EasyLoading.dismiss();
        var empty = ['no content'];
        print('no content available');
        return empty;
      } else {
        print("Error");
      }
    } catch (e) {
     //// await _storage.delete(key: 'token');
  ///    Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
