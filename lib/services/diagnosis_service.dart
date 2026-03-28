import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';

class DiagnosisService {
  static final _storage = FlutterSecureStorage();
  //static const String baseUrl = 'http://10.0.2.2:7000';
  //static const String baseUrl = 'http://192.168.122.66:7000';
  static String baseUrl = 'http://192.168.100.27:7000';

  // Get all diagnoses by sample
  static Future<dynamic> getAllDiagnosis(BuildContext context, String idsample) async {
    await EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      var res = await http.get(
        Uri.parse('$baseUrl/api/diognosis/all_by_sample/$idsample'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return ["no content"];
      }
    } catch (e) {
      print('Error fetching all diagnosis: $e');
      Navigator.pushReplacementNamed(context, '/login');
    } finally {
      await EasyLoading.dismiss();
    }
  }

  // Get diagnosis by ID
  static Future<dynamic> getDiagnosisById(BuildContext context) async {
    await EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      var id = await AuthService.getDiagnosisID();
      var res = await http.get(
        Uri.parse('$baseUrl/api/diognosis/one/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
    } catch (e) {
      print('Error fetching diagnosis by ID: $e');
      Navigator.pushReplacementNamed(context, '/login');
    } finally {
      await EasyLoading.dismiss();
    }
  }

  // Save a new diagnosis
  static Future<void> saveDiagnosis(
      String? test,
      String? laboratory,
      String? idsample,
      String date,
      int quantity,
      String result,
      String? species,
      BuildContext context,
      ) async {
    await EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      String id = await AuthService.getId();
      final msg = jsonEncode({
        "loginuser": id,
        "idsample": idsample,
        "test": test,
        "diagnosisdate": date,
        "quantite": quantity,
        "result": result,
        "leishsuspect": species,
        "laboratoryname": laboratory
      });

      var res = await http.post(
        Uri.parse('$baseUrl/api/diognosis/save'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: msg,
      );

      print("Save response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'New Diagnosis successfully added!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacementNamed(context, '/diagnosis');
      }
    } catch (e) {
      print('Error saving diagnosis: $e');
      Navigator.pushReplacementNamed(context, '/login');
    } finally {
      await EasyLoading.dismiss();
    }
  }

  // Get all laboratory names
  static Future<dynamic> getLaboratory(BuildContext context) async {
    try {
      var res = await http.get(
        Uri.parse('$baseUrl/api/laboratory/all_name'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("Lab response: ${res.statusCode} - ${res.body}");
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
    } catch (e) {
      print('Error fetching labs: $e');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Update existing diagnosis
  static Future<void> updateDiagnosis(
      String? test,
      String? laboratory,
      String? idsample,
      String date,
      String quantity,
      String result,
      String? species,
      BuildContext context,
      ) async {
    await EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      var diagnosisId = await AuthService.getDiagnosisID();
      var id = await AuthService.getId();
      final msg = jsonEncode({
        "iddiagnosis": diagnosisId,
        "loginuser": id,
        "idsample": idsample,
        "test": test,
        "diagnosisdate": date,
        "quantite": quantity,
        "result": result,
        "leishsuspect": species,
        "laboratoryname": laboratory
      });

      var res = await http.post(
        Uri.parse('$baseUrl/api/diognosis/update'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: msg,
      );

      print("Update response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Diagnosis successfully updated!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacementNamed(context, '/updatediagnosis');
      }
    } catch (e) {
      print('Error updating diagnosis: $e');
      Navigator.pushReplacementNamed(context, '/login');
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
