import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/switchbar.dart';

// ignore: camel_case_types
class Patient_Serivce {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
  //static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.122.66:7000';
  //static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.100.27:7000';

  // --- EXISTING METHOD FOR PATIENT COUNT CHART (All users) ---
  static Future<List<dynamic>?> getPatientCountByLoginUser(BuildContext context) async {
    try {
      final url = Uri.parse(BaseUrl + '/api/patient/count_by_user');

      var response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 204) {
        return [];
      } else {
        print('Failed to load user patient counts. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching patient counts: $e');
      return null;
    }
  }

  // -------------------------------------------------------------
  // 🚨 NEW METHOD: Get count for current user (API approach) 🚨
  // -------------------------------------------------------------
  static Future<int?> getPatientCountByCurrentUser(
      BuildContext context, String loginUser) async {

    try {
      // 1. Construct the URL for the dedicated counting endpoint
      // **NOTE:** Ensure your backend implements this endpoint (e.g., Spring Boot: @GetMapping("/api/patient/count_my_patients/{loginUser}"))
      final url = Uri.parse('${BaseUrl}/api/patient/count_my_patients/$loginUser');

      print('📡 Fetching patient count for $loginUser from URL: $url');

      var response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        // 2. Parse the response body directly into an integer.
        // Assumes backend returns a plain number (e.g., "12")
        int count = int.tryParse(response.body) ?? 0;
        return count;
      } else {
        print('Failed to load user patient count. Status: ${response.statusCode}');
        // You can show an error toast here if needed
        // Fluttertoast.showToast(msg: 'Failed to fetch your patient count.');
        return 0;
      }
    } catch (e) {
      print('Error in getPatientCountByCurrentUser: $e');
      // Fluttertoast.showToast(msg: 'Network error fetching count.');
      return null;
    }
  }
  // -------------------------------------------------------------


  // Get one patient by his ID
  static getpatientbyid(context) async {
    try {
      // var token = await _storage.read(key: 'token');
      var id = await AuthService.getPatientID();
      final fullUrl = '${BaseUrl}/api/patient/my_patient/$id';
      print("🧩 [Service] Received patientId: '$id'");
      print("📡 Full URL: $BaseUrl/api/patient/my_patient/$id");
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/patient/my_patient/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //  'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else {}
    } catch (e) {
      //    await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Get all patients by one user
  static getallpatients(context) async {
    try {
      //   var token = await _storage.read(key: 'token');
      var username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/patient/all_my/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //  'Authorization': 'Bearer $token',
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
      // await _storage.delete(key: 'token');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

// Get all patients by one user
  static fetchPatient(context, page) async {
    try {
      // var token = await _storage.read(key: 'token');
      //page= AuthService.
      var username = await AuthService.getLoginuser();

      var res = await http.get(
        Uri.parse(BaseUrl + '/api/patient/all_my/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //    'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        // Return is missing here
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        print('no content available');
      }
    } catch (e) {
      //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// Gel all patients by all users
  static allpatients(context) async {
    try {
      //var token = await _storage.read(key: 'token');
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/patient/all'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //    'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = await json.decode(res.body);
        await EasyLoading.dismiss();
        return data;
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
      //  await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Get patient's ID
  static getpatientid(context) async {
    try {
      //  var token = await _storage.read(key: 'token');
      var username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/patient/new_patient_id/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //   'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var data = res.body;
        await EasyLoading.dismiss();
        return data;
      } else {
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
      //    await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// ADD a new patient
  // ignore: non_constant_identifier_names
  static SavePatient(
      String mfn,
      String firstname,
      String lastname,
      String birthdate,
      int age,
      String nationality,
      String gender,
      String consent,
      String phone,
      BuildContext context) async {
    try {
      //  var token = await _storage.read(key: 'token');
      String username = await AuthService.getLoginuser();
      final msg = jsonEncode({
        "age": age,
        "loginuser": username,
        "medical_FILE_NUMBER": mfn,
        "last_NAME": lastname,
        "nationality": nationality,
        "consent": consent,
        "first_NAME": firstname,
        "gender": gender,
        "phone_NUMBER": phone,
        "birth_DATE": birthdate
      });
      var res = await http.post(
        Uri.parse(BaseUrl + '/api/patient/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          //   'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      if (res.statusCode == 201) {
        await EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const switchbar()),
        );
        Fluttertoast.showToast(
            msg: 'Patient successfully added !',
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
        await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
      // await _storage.delete(key: 'token');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// UPDATE an existant patient
  // ignore: non_constant_identifier_names
  static UpdatePatient(
      String patientIdentifier,
      String mfn,
      String firstname,
      String lastname,
      String birthdate,
      int age,
      String nationality,
      String gender,
      String consent,
      String phone,
      id,
      BuildContext context) async {
    try {
      //var token = await _storage.read(key: 'token');
      final msg = jsonEncode({
        "age": age,
        "loginuser": id,
        "medical_FILE_NUMBER": mfn,
        "patientidentifier": patientIdentifier,
        "last_NAME": lastname,
        "nationality": nationality,
        "consent": consent,
        "first_NAME": firstname,
        "gender": gender,
        "phone_NUMBER": phone,
        "birth_DATE": birthdate
      });
      var res = await http.put(
        Uri.parse(BaseUrl + '/api/patient/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          //  'Authorization': 'Bearer $token',
        },
        body: msg,
      );
      if (res.statusCode == 200) {
        await EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/patientProfile');
        Fluttertoast.showToast(
            msg: 'Patient successfully updated !',
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

