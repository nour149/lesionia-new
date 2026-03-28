import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/patient_service.dart';
import 'package:new_lesionia_project/widgets/customcard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:new_lesionia_project/Models/Patients.dart';


// ignore: camel_case_types
class all_patients extends StatefulWidget {
  const all_patients({Key? key}) : super(key: key);

  @override
  _all_patientsState createState() => _all_patientsState();
}

// ignore: camel_case_types
class _all_patientsState extends State<all_patients> {
  final _storage = FlutterSecureStorage();
  String txt = "";
  String error = "";
  final search = TextEditingController();
  int page = 1;
  List<dynamic> dataliste = [];
  List<dynamic> filterPatients = [];
  List<dynamic> filteredList = [];
  bool hasMore = true;
  bool searchable = false;
  Timer? _timer;
  final controller = ScrollController();
  int allpatients = 0;

  @override
  void initState() {
    super.initState();

    fetchAllPatients();

    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          hasMore) {
        fetchAllPatients();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var data = await Patient_Serivce.allpatients(context);
      if (data != null) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        if (!mounted) return;

        if (data == "Data Error") {
          setState(() {
            error = data;
          });
        } else {
          // Sécuriser les valeurs null
          setState(() {
            filterPatients = data.map((user) {
              return {
                'patient_id': user['patient_id']?.toString() ?? '',
                'first_name': user['first_name'] ?? '',
                'last_name': user['last_name'] ?? '',
                'medical_file_number': user['medical_file_number'] ?? '',
                'phone_number': user['phone_number'] ?? '',
                'birth_date': user['birth_date'] ?? '',
                'gender': user['gender'] ?? '',
              };
            }).toList();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    search.dispose();
    super.dispose();
  }

  Future fetchAllPatients() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var FROMINST = await AuthService.getINST();

      var res = await http.get(
        Uri.parse(
        'http://192.168.100.27:7000/api/patient/patients_frominst/IPT/$page',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);

        List<dynamic> newData = map['content'].map((user) {
          return {
            'patient_id': user['patient_id']?.toString() ?? '',
            'first_name': user['first_name'] ?? '',
            'last_name': user['last_name'] ?? '',
            'medical_file_number	': user['medical_file_number	'] ?? '',
            'phone_number': user['phone_number'] ?? '',
            'birth_date': user['birth_date'] ?? '',
            'gender': user['gender'] ?? '',
          };
        }).toList();

        setState(() {
          dataliste.addAll(newData);
          allpatients = map['totalElements'] ?? dataliste.length;
          page++;
          hasMore = !(map['last'] ?? true);
        });
      } else if (res.statusCode == 404) {
        setState(() {
          error = "Data Error";
        });
      } else {
        print('No content available');
      }
    } catch (e) {
      print("Fetch Error: $e");
    }
  }

  void _filterPatients(String query) {
    setState(() {
      txt = query;
      if (query.isNotEmpty) {
        searchable = true;
        filteredList = filterPatients
            .where((i) =>
            (i['first_NAME'] + ' ' + i['last_NAME'])
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        searchable = false;
        filteredList = dataliste;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    filteredList = searchable ? filteredList : dataliste;

    return Scaffold(
      backgroundColor: const Color(0xFFe1e1dd),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                controller: search,
                style: const TextStyle(color: Colors.black),
                onChanged: _filterPatients,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                    BorderSide(color: Colors.black.withOpacity(0.7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                    BorderSide(color: Colors.black.withOpacity(0.7)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "All Patients : ${filteredList.length}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredList.length + 1,
              itemBuilder: (context, index) {
                if (index < filteredList.length) {
                  final user = filteredList[index];
                  final patient = Patient.fromJson(user);
                  return getCard(patient, index, context);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: hasMore
                        ? const Center(child: CircularProgressIndicator())
                        : null,
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
