import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Alliquot_Service {
  static final _storage = FlutterSecureStorage();
  // Get all Alliquots
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.122.66:7000';
  //static String BaseUrl = 'http://192.168.114.240:7000';
  static String BaseUrl = 'https://192.168.114.92:7000';
   //static String BaseUrl = 'http://192.168.1.190:7000';
  static saveAlliquot(
      String idsample,
      double quantity,
      String type,
      String container,
      String rak,
      String conserve,
      int position,
      BuildContext context) async {
    try {
      //var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      final msg = jsonEncode({
        "idsample": idsample,
        "loginuser": id,
        "conservation_PLACE": "$type,$container,$rak,$conserve,$position",
        "volume": quantity
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/alliquot/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
         // 'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      print(res.statusCode);
      if (res.statusCode == 201) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/sample');
        Fluttertoast.showToast(
            msg: 'Alliquot successfully added !',
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
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
