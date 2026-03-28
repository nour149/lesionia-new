// ignore: camel_case_types
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

// ignore: camel_case_types
class Travel_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
  // static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.122.66:7000';
  // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';

// GET all travel Residencies
  static getalltravel(context ) async {
    try {
      //    var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/travel_residency/get_all/$idpatient'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //     'Authorization': 'Bearer $token',
        },
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        var data = await json.decode(utf8.decode(res.bodyBytes));
        await EasyLoading.dismiss();
        return data;
      } else if (res.statusCode == 204) {
        var empty = ['no content'];
        await EasyLoading.dismiss();
        print('no content available');
        return empty;
      }
    } catch (e) {
      //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

//GET all travel residencies by all patients
  static alltravels(context) async {
    try {
      //  var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/travel_residency/all'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          //    'Authorization': 'Bearer $token',
        },
      );
      // await EasyLoading.show(
      //   status: 'loading...',
      //   maskType: EasyLoadingMaskType.black,
      // );
      if (res.statusCode == 200) {
        var data = await json.decode(utf8.decode(res.bodyBytes));
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

  //GET travel residency by ID
//  static gettravelbyid(context,String idtravel) async {
  static gettravelbyid(context) async {
    try {
//      var token = await _storage.read(key: 'token');
      var IDMVT = await AuthService.getTravelID();

      var res = await http.get(
        Uri.parse(BaseUrl + '/api/travel_residency/get_one/$IDMVT'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          //  'Authorization': 'Bearer $token',
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
      //     await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

//UPDATE an existant Travel Residency
  static updateTravelResidency(
      String fromdate,
      double todate,
      String residency,
      String rural,
      String bitenotion,
      String city,
      BuildContext context,
      String IDMVT,  // <-- Argument correct (nommé en majuscules ici)
      String idpatient // <-- Argument correct (nommé en minuscules ici)
      ) async {
    try {
      // *** LIGNES SUPPRIMÉES/COMMENTÉES POUR UTILISER LES ARGUMENTS PASSÉS ***
      // var IDMVT = await AuthService.getTravelID();
      // var idpatient = await AuthService.getPatientID();
      //  var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      final msg = jsonEncode({
        "loginuser": id,
        "patientidentifier": idpatient, // Utilisation de l'argument idpatient
        "fromdate": fromdate,
        "todate": todate,
        "residency": residency,
        "type": rural,
        "IDMVT": IDMVT,                 // Utilisation de l'argument IDMVT
        "city": city,
        "bytenot": bitenotion,
        // *** CHAMP DUPLIQUÉ RETIRÉ ***
        // "idpatient":idpatient
      });
      var res = await http.put(
        Uri.parse(BaseUrl + '/api/travel_residency/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          //    'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/travelresidency');

        Fluttertoast.showToast(
            msg: 'Travel Residency successfully updated !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
      } else {
        // Ajout d'une gestion d'erreur plus informative si la mise à jour échoue
        await EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: 'Update failed. Status code: ${res.statusCode}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);
      }
    } catch (e) {
      // await _storage.delete(key: 'token');
      await EasyLoading.dismiss();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // ADD a new Travel Residency
  static saveTravelResidency(
      String fromdate,
      double todate,
      String residency,
      String rural,
      String bitenotion,
      String city,
      BuildContext context) async {
    try {
      var idpatient = await AuthService.getPatientID();
      //  var token = await _storage.read(key: 'token');
      String id = await AuthService.getId();
      final msg = jsonEncode({
        "loginuser": id,
        "patientidentifier": idpatient,
        "fromdate": fromdate,
        "todate": todate,
        "residency": residency,
        "type": rural,
        "city": city,
        "bytenot": bitenotion
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/travel_residency/save'),
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
        Navigator.pushReplacementNamed(context, '/travelresidency');
        Fluttertoast.showToast(
            msg: 'Travel Residency successfully added !',
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
      await EasyLoading.dismiss();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}