import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_lesionia_project/Models/Patients.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/patient_service.dart';
import 'package:new_lesionia_project/widgets/customcard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import 'Models/Patients.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);


  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final _storage = FlutterSecureStorage();
  int page = 0;
  List<dynamic> dataliste = [];
  List myList = [];
  List patients = [];
  var search = TextEditingController();
  bool hasMore = true;
  bool searchable = false;
  final controller = ScrollController();
  String txt = "";
  MokFetch() async {
    var data;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Patient_Serivce.getallpatients(context);
      if (data != null) {
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        if (!mounted) {
          return;
        } else {
          if (data == "Data Error") {
            setState(() {
              Error = data;
            });
          } else {
            setState(() {
              patients = data;
            });
          }
        }
      }
    });
  }

  // ignore: non_constant_identifier_names
  String Error = "";
  List filteredList = [];
  List filteredList2 = [];

  Timer? _timer;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetchPatient() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      ///   var token = await _storage.read(key: 'token');
      var username = await AuthService.getLoginuser();
      var res = await http.get(
        Uri.parse('http://192.168.100.27:7000/api/patient/allpage/$page/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //  //'Authorization': 'Bearer $token',
        },
      );
      if (!mounted) return;
      if (res.statusCode == 200) {
        Map<String, dynamic> map = await json.decode(res.body);

        setState(() {
          page++;       });
        setState(() {
          dataliste.addAll(map['content']);
        });
        if (map['last'] == true) {
          hasMore = false;
        }
        // await EasyLoading.dismiss();
      } else if (res.statusCode == 404) {
        return "Data Error";
      } else {
        // await EasyLoading.dismiss();
        print('no content available');
      }
    } catch (e) {
      ////// await _storage.delete(key: 'token');
      /////Navigator.pushReplacementNamed(context, '/login');
      print('Erreur lors de la récupération des patients: $e');
    }
  }

  void initState() {
    var data;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Patient_Serivce.getallpatients(context);
      if (data != null) {
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        if (!mounted) {
          return;
        } else {
          if (data == "Data Error") {
            setState(() {
              Error = data;
            });
          } else {
            setState(() {
              patients = data;
            });
          }
        }
      }
    });
    super.initState();

    fetchPatient();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        fetchPatient();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (search.text.isNotEmpty) {
      if (search.text.length > 0) {
        setState(() {
          searchable = true;
        });
        setState(() {
          filteredList = patients
              .where((i) => (i['first_name'] + ' ' + i['last_name'])
              .toLowerCase()
              .contains(txt.toLowerCase()))
              .toList();
        });
      }
    } else {
      setState(() {
        searchable = false;
        filteredList = dataliste;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFe1e1dd),
      body: SingleChildScrollView(
        controller: controller,
        child: (Error.contains("Data Error"))
            ? Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: ShimmerLayout(),
        )
            : Column(
          children: [
            Container(
              child: Form(
                child: Container(
                  child: SizedBox(
                    child: Column(children: [
                      new Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          child: Row(
                            children: [
                              Flexible(
                                  child: TextField(
                                    controller: search,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (text) {
                                      setState(() {
                                        txt = text;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      ),
                                      hintText: 'Search',
                                      hintStyle:
                                      TextStyle(color: Colors.black),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.black),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Colors.black
                                                .withOpacity(0.7)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Colors.black
                                                .withOpacity(0.7)),
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                    ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 20),
              child: Row(
                children: [
                  Text(
                    (search.text.isEmpty)
                        ? "Total Patients : ${patients.length.toString()}"
                        : "Total Patients : " +
                        filteredList.length.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              InkWell(
                onTap: () => Navigator.pushReplacementNamed(
                    context, '/addpatient'),
                child: Row(children: [
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 20.0),
                                blurRadius: 30.0,
                                color: Colors.black12)
                          ],
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0)),
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 30.0),
                          child: Text(
                            'Add Patient',
                            style:
                            Theme.of(context).textTheme.labelLarge!  // or labelMedium depending on your needs
                                .apply(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF077064),
                              border: Border.all(
                                  color: Colors.black45,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(74.0),
                                  topLeft: Radius.circular(74.0),
                                  bottomRight: Radius.circular(200.0))),
                        ),
                        Container(
                          width: 80,
                          child: Image.asset(
                            "assets/add_patient.png",
                          ),
                        ),
                      ]))
                ]),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredList.length + 1,
              itemBuilder: (context, index) {
                if (index < filteredList.length) {
                  final user = filteredList[index];
                  final patient = Patient.fromJson(user);
                  return getCard(patient, index, context);


                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: (searchable)
                        ? null
                        : Center(
                      child: hasMore
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Form(
            child: Container(
              child: SizedBox(
                child: Column(children: [
                  new Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Flexible(
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon:
                                  Icon(Icons.search, color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.white12,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                ),
                              ))
                        ],
                      )),
                ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          child: Row(
            children: [
              Text(
                "Total Patients : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(children: [
          InkWell(
            child: Row(children: [
              SizedBox(
                width: 80,
              ),
              Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0, 20.0),
                            blurRadius: 30.0,
                            color: Colors.black12)
                      ],
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)),
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Text(
                        'Add Patient',
                        style:
                        Theme.of(context).textTheme.labelLarge!  // or labelMedium depending on your needs
                            .apply(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF077064),
                          border: Border.all(
                              color: Colors.black45, style: BorderStyle.solid),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(74.0),
                              topLeft: Radius.circular(74.0),
                              bottomRight: Radius.circular(200.0))),
                    ),
                    Container(
                      width: 80,
                      child: Image.asset(
                        "assets/add_patient.png",
                      ),
                    ),
                  ]))
            ]),
          ),
        ]),
        SizedBox(
          height: 30,
        ),
        new ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 4,
            itemBuilder: (context, index) {
              return getCardShimmer();
            }),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
