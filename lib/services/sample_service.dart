// ignore: camel_case_types
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Sample_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
  // static String BaseUrl = 'http://192.168.122.66:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';

  static getSampleID(context) async {
    try {
      // var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/sample/all_id/$idpatient'),
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
      } else {}
    } catch (e) {
      //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  //GET all samples by ID
  static getallsamplesbyid(context) async {
    try {
      //   var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/sample/all_my/$idpatient'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
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
        var data = await json.decode(utf8.decode(res.bodyBytes));

        return data;
      } else if (res.statusCode == 204) {
        var empty = ['no content'];
        await EasyLoading.dismiss();
        print('no content available');
        return empty;
      }
    } catch (e) {
      //   await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Checking if there is any sample
  static samplechecking(context) async {
    try {
      //    var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/sample/all_my/$idpatient'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          //   'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = await json.decode(utf8.decode(res.bodyBytes));

        return data;
      } else if (res.statusCode == 204) {
        var empty = ['no content'];
        print('no content available');
        return empty;
      }
    } catch (e) {
      //     await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// GET ONE SAMPLE BY ID
  static getsamplebyid(context) async {
    try {
      //  var token = await _storage.read(key: 'token');
      var idsample = await AuthService.getSampleID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/sample/get_one/$idsample'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          //   'Authorization': 'Bearer $token',
        },
      );
      // await EasyLoading.show(
      //   status: 'loading...',
      //   maskType: EasyLoadingMaskType.black,
      // );
      if (res.statusCode == 200) {
        // await EasyLoading.dismiss();
        var data = await json.decode(utf8.decode(res.bodyBytes));

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

// ADD New Sample
  static saveSample(
      String description,
      double age,
      double max,
      double min,
      double height,
      String sampling,
      String checkupdate,
      String typeofsample,
      String abudance,
      String examination,
      String dateapeard,
      String lesionSiteSampled,
      String localisation,
      BuildContext context) async {
    try {
      var username = await AuthService.getLoginuser();
      var idpatient = await AuthService.getPatientID();
      //  var token = await _storage.read(key: 'token');
      final msg = jsonEncode({
        "loginuser": username,
        "date_EXTRACTION": checkupdate,
        "description": description,
        "lesion_Age": age,
        "diametremax": max,
        "diametremin": min,
        "sampling_METHOD": sampling,
        "species": "",
        "hight": height,
        "localisation": localisation,
        "patientidentifier": idpatient,
        "lesion_SITE_SAMPLED": lesionSiteSampled,
        "type_OF_SAMPLE_SUPPORT_": typeofsample,
        "abudance_ON_THE_SMEAR": abudance,
        "direct_EXAMINATION": examination,
        "date_First_Apeard": dateapeard
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/sample/save'),
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

        // Navigator.pushReplacementNamed(context, '/sample');
        Fluttertoast.showToast(
            msg: 'New Sample successfully added !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);

        return res.body;
      } else {}
    } catch (e) {
      //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // UPDATE an Existant Sample
  static updateSample(
      String description,
      double age,
      double max,
      double min,
      double height,
      String sampling,
      String checkupdate,
      String typeofsample,
      String abudance,
      String examination,
      String dateapeard,
      String lesionSiteSampled,
      String localisation,
      BuildContext context) async {
    try {
      var username = await AuthService.getLoginuser();
      var idpatient = await AuthService.getPatientID();
      //  var token = await _storage.read(key: 'token');
      var idsample = await AuthService.getSampleID();
      final msg = jsonEncode({
        "idsample": idsample,
        "loginuser": username,
        "date_EXTRACTION": checkupdate,
        "description": description,
        "lesion_Age": age,
        "diametremax": max,
        "diametremin": min,
        "sampling_METHOD": sampling,
        "species": "",
        "hight": height,
        "localisation": localisation,
        "patientidentifier": idpatient,
        "lesion_SITE_SAMPLED": lesionSiteSampled,
        "type_OF_SAMPLE_SUPPORT_": typeofsample,
        "abudance_ON_THE_SMEAR": abudance,
        "direct_EXAMINATION": examination,
        "date_First_Apeard": dateapeard
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/sample/update'),
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
        Navigator.pushReplacementNamed(context, '/updatesample');
        Fluttertoast.showToast(
            msg: 'Sample successfully updated !',
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
