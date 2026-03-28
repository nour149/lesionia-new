// ignore: camel_case_types
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Discrepancy_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
//  static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';
  static getalldiscrepancies(context) async {
    try {
     // var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/discrepancy/all_my/ipt220015'),
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
      } else if (res.statusCode == 204) {
        var empty = ['no content'];
        await EasyLoading.dismiss();
        print('no content available');
        return empty;
      }
    } catch (e) {
     // await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Get a Discrepancy by ID
  static getdiscrepancybyid(context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var id = await AuthService.getDiscrepancyID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/discrepancy/one/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        //  'Authorization': 'Bearer $token',
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
        print('no content available');
      }
    } catch (e) {
    //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // ADD a new Discrepancy
  static saveDiscrepancy(
      String description, String? datmed, String? date_disc, BuildContext context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      String username = await AuthService.getLoginuser();
      var idpatient = await AuthService.getPatientID();

      final msg = jsonEncode({
        "user": username,
        "description": description,
        "patientidentifier": idpatient,
         "date_disc" :date_disc,
        "datemed": datmed,

      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/discrepancy/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
       //   'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 201) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/discrepancy');
        Fluttertoast.showToast(
            msg: 'New Discrepancy successfully added !',
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
     // await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static updateDiscrepancy(
      String? datmed, String description, BuildContext context) async {
    try {
   //   var token = await _storage.read(key: 'token');
      var discrepancyid = await AuthService.getDiscrepancyID();
      var idpatient = await AuthService.getPatientID();
      String username = await AuthService.getLoginuser();
      final msg = jsonEncode({
        "iddiscrepancy": discrepancyid,
        "user": username,
        "description": description,
        "patientidentifier": idpatient,
        "datemed": datmed
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/discrepancy/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        //  'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/updatediscrepancy');
        Fluttertoast.showToast(
            msg: 'Discrepancy successfully updated !',
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
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
