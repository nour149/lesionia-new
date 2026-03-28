
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class MolecularTest_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
 // static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';
// Get all molecular_tests
  static getalltests(context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/molecularl_test/all_test'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //'Authorization': 'Bearer $token',
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
    //  await _storage.delete(key: 'token');
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
