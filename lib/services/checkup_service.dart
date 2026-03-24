import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Checkup_Service {
  static final _storage = FlutterSecureStorage();
  // Get all medical checkups
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
 // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.114.92:7000';

  static getallcheckups(context) async {
    try {
    //  var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/medical_checkup/all/$idpatient'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
         // 'Authorization': 'Bearer $token',
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
        await EasyLoading.dismiss();
        var empty = ['no content'];
        print('no content available');
        return empty;
      } else {
        print("Error");
      }
    } catch (e) {
   //   await _storage.delete(key: 'token');
   //   Navigator.pushReplacementNamed(context, '/login');
    }
  }

//GET all medical checkups by all patients
  static allcheckups(context) async {
    try {
     // var token = await _storage.read(key: 'token');
        var res = await http.get(
        Uri.parse(BaseUrl + '/api/medical_checkup/all'),
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
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        // await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
     // await _storage.delete(key: 'token');
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Get a medical checkup by ID
  static getcheckupbyid(context) async {
    try {
     // var token = await _storage.read(key: 'token');
      var id = await AuthService.getCheckupID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/medical_checkup/my_medical_checkup/$id'),
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
      } else {
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
     // await _storage.delete(key: 'token');
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static saveCheckup(
      String hospital,
      String physician,
      String sampler,
      String checkupdate,
      String clinicalState,
      String surroundinghuman,
      String linkwithhuman,
      String possibleanimal,
      int numberoflesions,
      String lesionlocalisation,
      BuildContext context) async {
    try {
      var idpatient = await AuthService.getPatientID();
     // var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      String interrogatorid = await AuthService.getInterrogatorID();
      final msg = jsonEncode({
        "gendesc": null,
        "hospital": hospital,
        "lesnum": numberoflesions,
        "sampler": sampler,
        "clinical_STATE": clinicalState,
        "lesposss": lesionlocalisation,
        "date_MED": checkupdate,
        "animal_AROUND": possibleanimal,
        "physician": physician,
        "possible_HUMAN_HOSTS": surroundinghuman,
        "patientidentifier": idpatient,
        "link_HUMAN_HOSTS": linkwithhuman,
        "loginuser": id,
        "id_INTERROGATOR": interrogatorid
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/medical_checkup/save'),
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
      if (res.statusCode == 201) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/checkup');
        Fluttertoast.showToast(
            msg: 'Medical Checkup successfully added !',
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
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static updateCheckup(
      String hospital,
      String physician,
      String sampler,
      String checkupdate,
      String clinicalState,
      String surroundinghuman,
      String linkwithhuman,
      String possibleanimal,
      int numberoflesions,
      String lesionlocalisation,
      BuildContext context) async {
    try {
      var idpatient = await AuthService.getPatientID();

      var idcheckup = await AuthService.getCheckupID();
      var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      String interrogatorid = await AuthService.getInterrogatorID();
      final msg = jsonEncode({
        "gendesc": null,
        "hospital": hospital,
        "lesnum": numberoflesions,
        "sampler": sampler,
        "clinical_STATE": clinicalState,
        "lesposss": lesionlocalisation,
        "date_MED": checkupdate,
        "animal_AROUND": possibleanimal,
        "physician": physician,
        "idmed": idcheckup,
        "possible_HUMAN_HOSTS": surroundinghuman,
        "patientidentifier": idpatient,
        "link_HUMAN_HOSTS": linkwithhuman,
        "loginuser": id,
        "id_INTERROGATOR": interrogatorid
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/medical_checkup/update'),
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
        Navigator.pushReplacementNamed(context, '/updatecheckup');
        Fluttertoast.showToast(
            msg: 'Medical Checkup successfully updated !',
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
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Get all checkups DATES
  static getallcheckupsdate(context) async {
    try {
     // var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/medical_checkup/all_date/$idpatient'),
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
        await EasyLoading.dismiss();
        return data;
      } else {
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
     // await _storage.delete(key: 'token');
     // Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
