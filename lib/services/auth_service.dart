import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

class AuthService {
  static final _storage = FlutterSecureStorage();

  // ignore: non_constant_identifier_names
  //10.0.2.2:8080
  //static String BaseUrl = 'http://10.0.2.2:7000';
  //static String BaseUrl = 'http://192.168.114.53:7000';
  //static String BaseUrl = 'http://192.168.114.240:7000';
  // 192.168.114.2
  static String BaseUrl = 'https://192.168.100.27:7000';
  // static String BaseUrl = 'http://192.168.1.190:7000';
  static Future<void> fetchAndStoreEmail(String loginuser) async {
    try {
      var res = await http.get(
        Uri.parse('$BaseUrl/api/user/email/$loginuser'),
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        if (data['email'] != null) {
          await setEmail(data['email']);
          print("Email saved: ${data['email']}");
        } else {
          print("Email not found in response");
        }
      } else {
        print("Failed to fetch email. Status: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching email: $e");
    }
  }

  // LOGIN TO HOME
  static login(String username, String password,  BuildContext context) async {
    Map<String, dynamic> formMap = {'loginuser': username, 'motdpass': password };
    try {
      final result = await InternetAddress.lookup('example.com');
      print(result);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        String ch;
        var res = await http.post(
          Uri.parse(BaseUrl + '/api/user/login'),
          headers: {
            "Content-Type": "application/json",  // Use JSON content type
          },
          body: jsonEncode({
            'loginuser': username,
            'motdpass': password,


          }),
        );

        var data = json.decode(res.body);
        print(
            "Response Data: $data"); // Log the response data to check for issues

        if (res.statusCode == 200 &&
            data['result'].toString().trim().toLowerCase() ==
                "well connected") {
          print('Logged in successfully'); // Check if the login was successful before navigation.
          await setLoginuser(username);
          await fetchAndStoreEmail(username); // <== Call added here

          String email = await AuthService.getEmail();
          print("Email from storage: $email");
          //store levelsecure
          String levelsecure = data['levelsecure'] ?? 'user';
          print("levelsecure:  $levelsecure");
          await setLevelsecure(levelsecure);

          if (levelsecure == 'admin')
          {
            Navigator.pushReplacementNamed(context, '/adminhome');

          }
          else {
            if( levelsecure == 'user')
            {
              Navigator.pushReplacementNamed(context, '/home');

            }
            //    Navigator.pushReplacementNamed(context, '/home');
            // Ensure the path and navigation logic are correct.
          }
        } else {
          Fluttertoast.showToast(
            msg: "Email or password incorrect",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true,
          );
        }
      }
    } on SocketException catch (e) {
      print("SocketException: $e");

      Fluttertoast.showToast(
        msg: "Check your connection and try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        webBgColor: "#FF0000",
        webPosition: "center",
        fontSize: 16.0,
        webShowClose: true,
      );
    }
  }

  static setId(String payload) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('id', payload);
  }

  static setToken(String token, String payload) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
    await _prefs.setString('id', payload);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');

    return token;
  }

  static getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = (prefs.getString('id') ?? '');


    return id;
  }

  static removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static setInterrogatorID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('interrogator_id', id);
  }

  static getInterrogatorID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('interrogator_id') ?? '');
    return id;
  }

  static setPatientID(String patientIdentifier) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('patientIdentifier', patientIdentifier);
  }

  static Future<String> getPatientID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String patientIdentifier = (_prefs.getString('patientIdentifier') ?? '');
    return patientIdentifier;
  }

  static setCheckupID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('checkup_id', id);
  }

  static Future<String> getCheckupID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('checkup_id') ?? '');
    return id;
  }

  static setTravelID(String IDMVT) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('IDMVT', IDMVT);
  }

  static Future<String> getTravelID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
 //   String id = (_prefs.getString('travel_id') ?? '');
    String IDMVT =(_prefs.getString('IDMVT') ?? '');
    return IDMVT;
  }

  static setCode(String code) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('code', code);
  }

  static Future<String> getCode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String code = (_prefs.getString('code') ?? '');
    return code;
  }


  static setLoginuser(String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('loginuser', username);
  }
  static setEmail(String email) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('email', email);
  }

  static Future<String> getLoginuser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String username = _prefs.getString('loginuser') ?? '';
    return username;
  }


  static Future <String>  getEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String email = (_prefs.getString('email') ?? '');
    return email;
  }

  static setTreatmentID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('treatment_id', id);
  }

  static Future<String> getTreatmentID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('treatment_id') ?? '');
    return id;
  }

  static setDiagnosisID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('diagnosis_id', id);
  }

  static Future<String> getDiagnosisID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('diagnosis_id') ?? '');
    return id;
  }

  static setDiscrepancyID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('discrepancy_id', id);
  }

  static  Future<String> getDiscrepancyID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('discrepancy_id') ?? '');
    return id;
  }

  static setSampleID(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('sample_id', id);
  }

  static Future<String> getSampleID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String id = (_prefs.getString('sample_id') ?? '');
    return id;
  }

  static setINST(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('FROMINST', id);
  }

  static Future<String> getINST() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String FROMINST = (_prefs.getString('FROMINST') ?? '');
    print("INST from SharedPreferences: $FROMINST");
    return FROMINST;
  }

  static Future <String>  getLevelsecure() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String levelsecure = (_prefs.getString('levelsecure') ?? '');
    print("levelsecure from SharedPreferences: $levelsecure");
    return levelsecure;
  }
  static setLevelsecure(String levelsecure) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('levelsecure', levelsecure);
  }


}
