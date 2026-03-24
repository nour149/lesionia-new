import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';

// ignore: camel_case_types
class Image_Service {
  static final _storage = FlutterSecureStorage();
  // ignore: non_constant_identifier_names
 // static String BaseUrl = 'http://10.0.2.2:7000';
 // static String BaseUrl = 'http://192.168.122.66:7000';
 // static String BaseUrl = 'http://192.168.114.53:7000';
  static String BaseUrl = 'http://192.168.114.92:7000';

  //UPLOAD an image into a Folder

  // ignore: non_constant_identifier_names
  static Upload(
      File? imageFile, context, String checkupdate, String idsample) async {
    try {
      var stream =
          // ignore: deprecated_member_use
          new http.ByteStream(DelegatingStream.typed(imageFile!.openRead()));
      var length = await imageFile.length();
   //   var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      var username = await AuthService.getLoginuser();
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
       // 'Authorization': 'Bearer $token'
      };
      var uri = Uri.parse(BaseUrl + '/api/image/upload');
      var request = new http.MultipartRequest("POST", uri);
      request.headers.addAll(headers);
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));
      // contentType: new MediaType(imageFile.path, 'png'));

      request.files.add(multipartFile);
      request.fields['id_patient'] = idpatient;
      request.fields['loginuser'] = username;
      request.fields['idsample'] = idsample;
      request.fields['DATE_MED'] = checkupdate;
      var response = await request.send();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Image successfully uploaded !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4,
            textColor: Colors.white,
            webBgColor: "#FF0000",
            webPosition: "center",
            fontSize: 16.0,
            webShowClose: true);

    // 🔄 Attendre 5 secondes le traitement Python
    await Future.delayed(Duration(seconds: 5));

    // 🔁 Charger les nouvelles images prédictées
    var updatedImages = await getallimagesdata(context);

    // 🎯 Affichage (si contexte autorise setState via un callback ou autre)
    print("Images mises à jour : $updatedImages");


      } else {
        Fluttertoast.showToast(
            msg: 'Error while uploading',
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

      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } catch (e) {
    //  await _storage.delete(key: 'token');
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/patientsDetail');
      });
    }
  }

  static GetAllImages(context, path) async {
    try {
      Map<String, String> queryParameters = {
        'path': path,
      };
    ///  var token = await _storage.read(key: 'token');
      var idpatient = await AuthService.getPatientID();
      //Uri.http("10.0.2.2:7000", '/api/image/Getimage', queryParameters);
     //Uri.http("192.168.114.154:7000", '/api/image/Getimage', queryParameters);
// Corrected URI construction:
      final uri = Uri.parse(BaseUrl + '/api/image/Getimage').replace(queryParameters: queryParameters);
      var res = await http.get(
        uri,
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

      final bytes = Uint8List.fromList(res.bodyBytes);
      //     final codec = await instantiateImageCodec(bytes);
      // final frameInfo = await codec.getNextFrame();
      // await EasyLoading.dismiss();
      return bytes;
      // var data = await res.body;
      // await EasyLoading.dismiss();
      // return data;nouha  nouha

    } catch (e) {
     // await AuthService.removeToken();
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/patientsDetail');
      });
    }
  }

  static getallimagesdata(context) async {
    try {
   //   var token = await _storage.read(key: 'token');
      var id = await AuthService.getPatientID();
      var res = await http.get(
        Uri.parse(BaseUrl + '/api/image/all/$id'),
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
      } else if (res.statusCode == 204) {
        // await EasyLoading.dismiss();
        var empty = ['no content'];
        print('no content available');
        return empty;
      }
    } catch (e) {
    //  await AuthService.removeToken();
      Navigator.pushReplacementNamed(context, '/patientsDetail');
    }
  }
}
