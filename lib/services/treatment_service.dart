import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Treatment_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
 // static String BaseUrl = 'http://10.0.2.2:8080';
//  static String BaseUrl = 'http://192.168.122.66:7000';
 // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http:/192.168.114.92:7000';
// ADD a new Treatment History
  static saveTreatmentHistory(
      String historical,
      String prescribed,
      String treatmentDate,
      String healingDate,
      String duration,
      String posology,
      String adminroot,
      String numberofinjection,
      BuildContext context) async {
    try {
      var idpatient = await AuthService.getPatientID();
     // var token = await _storage.read(key: 'token');
      final msg = jsonEncode({
        "patientidentifier": idpatient,
        "injection_NUMBER": numberofinjection,
        "prescribedfor": prescribed,
        "start_DATE": treatmentDate,
        "healing_DATE": healingDate,
        "posology": posology,
        "treatment_TYPE": historical,
        "adminroute": adminroot,
        "durationn": duration
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/treatmenthistory/save'),
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
        Navigator.pushReplacementNamed(context, '/treatmenthistory');
        Fluttertoast.showToast(
            msg: 'Treatment History successfully added !',
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

  static getalltreatment(context) async {
    try {
      var idpatient = await AuthService.getPatientID();

      // Debug: Check if the ID is actually there
      print("Requesting: ${BaseUrl}/api/treatmenthistory/all/$idpatient");

      var res = await http.get(
        Uri.parse(BaseUrl + '/api/treatmenthistory/all/$idpatient'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10)); // Add a timeout

      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else if (res.statusCode == 204) {
        return ['no content'];
      } else {
        print("Server Error: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      print("CATCH ERROR: $e"); // This will tell you the REAL reason in the console
      // REMOVE the Navigator redirect here so it doesn't kick you out during debugging
      // Navigator.pushReplacementNamed(context, '/login');
      return null;
    }
  }

//GET all treatment histories by all patients
  static alltreatments(context) async {
    try {
  //    var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/treatmenthistory/all'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
      //    'Authorization': 'Bearer $token',
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
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        // await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
     // await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// GET Treatment History by ID
  static gettreatmentbyid(context) async {
    try {
  //    var token = await _storage.read(key: 'token');
      var idtreatment = await AuthService.getTreatmentID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/treatmenthistory/get_one/$idtreatment'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //'Authorization': 'Bearer $token',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        var data = await json.decode(res.body);

        return data;
      } else {
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
    //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// UPDATE an existant Treatment History
  static updateTreatmentHistory(
      String historical,
      String prescribed,
      String treatmentDate,
      String duration,
      String posology,
      String adminroot,
      String numberofinjection,
      BuildContext context) async {
    try {
      var idtreatment = await AuthService.getTreatmentID();
      var idpatient = await AuthService.getPatientID();
   //   var token = await _storage.read(key: 'token');
      final msg = jsonEncode({
        "idtreatment": idtreatment,
        "patientidentifier": idpatient,
        "injection_NUMBER": numberofinjection,
        "prescribedfor": prescribed,
        "start_DATE": treatmentDate,
        "healing_DATE": "???",
        "posology": posology,
        "treatment_TYPE": historical,
        "adminroute": adminroot,
        "durationn": duration
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/treatmenthistory/update'),
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
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/updatetreatment');
        Fluttertoast.showToast(
            msg: 'Treatment History successfully updated !',
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
}
