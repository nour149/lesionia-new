import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/patient_service.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: camel_case_types
class patientProfile extends StatefulWidget {
  const patientProfile({Key? key}) : super(key: key);

  @override
  _patientProfileState createState() => _patientProfileState();
}

enum Gender { Male, Female }
enum SingingCharacter { yes, no, na }

// ignore: camel_case_types
class _patientProfileState extends State<patientProfile> {
  late DateTime pickedDate;

  late DateTime dateNow;
  final mfn = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final age = TextEditingController();
  final nationality = TextEditingController();
  final phone = TextEditingController();
  Timer? _timer;
  String idpatient = '';
  // ignore: non_constant_identifier_names
  Gender? _Gender;
  SingingCharacter? _character;
  String gender = "";
  String consent = "";
  String loginuser = "";

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    if (mounted) {
      super.setState(fn);
    }
  }

  void initState() {
    var data;
    pickedDate = DateTime.now();
    dateNow = DateTime.now();
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      await _loadCounter();
      Future.delayed(Duration(seconds: 0, microseconds: 555555), () async {
        data = await Patient_Serivce.getpatientbyid(context);
        if (data != null) {
          setState(() {
            gender = data['gender'];
            consent = data['consent'];
            pickedDate = DateTime.parse(data['birth_DATE']);
            mfn.text = data['medical_FILE_NUMBER'];
            firstname.text = data['first_NAME'];
            lastname.text = data['last_NAME'];
            nationality.text = data['nationality'];
            phone.text = data['phone_NUMBER'];
            loginuser = data['loginuser'];
          });

          if (gender == "Male") {
            setState(() {
              _Gender = Gender.Male;
            });
          } else {
            setState(() {
              _Gender = Gender.Female;
            });
          }
          if (consent == "N/A") {
            setState(() {
              _character = SingingCharacter.na;
            });
          } else if (consent == "Yes") {
            setState(() {
              _character = SingingCharacter.yes;
            });
          } else {
            setState(() {
              _character = SingingCharacter.no;
            });
          }
        }
      });
    });
  }

  _loadCounter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (_prefs.getString('patientidentifier') ?? '');
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/patientsDetail',
        );
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (new Color(0xff088274)),
                  Colors.greenAccent,
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          title: Center(child: Text(idpatient)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.pushReplacementNamed(
                context,
                '/patientsDetail',
              )
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "PATIENT INFORMATION",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(
                  top: 30,
                ),
                child: Stack(
                  children: [
                    (gender == "Female")
                        ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: AssetImage("assets/patientF.png"),
                    )
                        : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: AssetImage("assets/patientt.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${firstname.text} ${lastname.text}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 45,
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Medical File Number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                height: 10 * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: 10 * 4,
                ).copyWith(bottom: 15 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.grey[100],
                ),
                child: TextFormField(
                    controller: mfn,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please enter Patient's first name";
                      else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'First Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                height: 10 * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: 10 * 4,
                ).copyWith(bottom: 15 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.grey[100],
                ),
                child: TextFormField(
                    controller: firstname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please enter Patient's first name";
                      else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Last Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                height: 10 * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: 10 * 4,
                ).copyWith(bottom: 15 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.grey[100],
                ),
                child: TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please enter Patient's first name";
                      else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Birth date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                  height: 10 * 5.5,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10 * 4,
                  ).copyWith(bottom: 15 * 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10 * 3),
                    color: Colors.grey[100],
                  ),
                  child: ListTile(
                    title: Text(
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    onTap: () {
                      _pickDate(context);
                    },
                  )),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Nationality',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                height: 10 * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: 10 * 4,
                ).copyWith(bottom: 15 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.grey[100],
                ),
                child: TextFormField(
                    controller: nationality,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please enter Patient's first name";
                      else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                        title: Text(
                          'Male',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: Gender.Male,
                        groupValue: _Gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _Gender = value;
                            gender = "Male";
                          });
                        }),
                    RadioListTile(
                        title: Text(
                          'Female',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: Gender.Female,
                        groupValue: _Gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _Gender = value;
                            gender = "Female";
                          });
                        }),
                  ],
                ),
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Consent',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio<SingingCharacter>(
                          value: SingingCharacter.yes,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              consent = "Yes";
                            });
                          }),
                      Text(
                        'Yes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: SingingCharacter.no,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              consent = "No";
                            });
                          }),
                      Text(
                        'No',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: SingingCharacter.na,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              consent = "N/A";
                            });
                          }),
                      Text(
                        'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                  height: 30,
                  width: 250,
                  child: Text(
                    'Phone number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                height: 10 * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: 10 * 4,
                ).copyWith(bottom: 15 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.grey[100],
                ),
                child: TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please enter Phone number";
                      else {
                        return null;
                      }
                    }),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (
                        BuildContext contextt,
                        ) {
                      return CupertinoAlertDialog(
                        title: const Text('Verify Patient ID'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  "Are you sure that you want to update Patient's information ?"),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () async {//
                               await Patient_Serivce.UpdatePatient(
                                 idpatient,
                                 mfn.text,
                                 firstname.text,
                                lastname.text,
                                correctlyFormattedDateTime(pickedDate),
                                dateNow.year - pickedDate.year,
                                 nationality.text,
                                gender,
                                 consent,
                                 phone.text,
                                 loginuser,
                                  context);
                            },
                          ),
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.pop(contextt);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 30, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xFF6DD6CA)),
                      new Color(0xff088274)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Text(
                    "Update Patient",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              )
            ],
          ),
        ),
      ),
    );
  }

  _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      locale: const Locale('fr', 'FR'),
      fieldHintText: 'dd/mm/yyyy',
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 65),
      lastDate: DateTime(DateTime.now().year + 5),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    // ignore: unnecessary_null_comparison
    if (date != null)
      setState(() {
        pickedDate = date;
      });
    else {
      print('put a Birth date');
    }
  }
}
