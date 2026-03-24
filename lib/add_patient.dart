import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/switchbar.dart';
import 'package:new_lesionia_project/services/patient_service.dart';
class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

enum SingingCharacter { yes, no, na }
enum Gender { Male, Female }

class _AddPatientState extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();

  final mfn = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final age = TextEditingController();
  final nationality = TextEditingController();
  final phone = TextEditingController();
  int agee = 0;
  late DateTime pickedDate;
  late DateTime dateNow;
  String consent = "N/A";
  String gender = "Male";
  var data;
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.parse('1900-01-01');
    dateNow = DateTime.now();
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   data = await AuthService.getpatientid();
    //   if (data != null) {
    //     print(data);
    //     EasyLoading.addStatusCallback((status) {
    //       print('EasyLoading Status $status');
    //       if (status == EasyLoadingStatus.dismiss) {
    //         _timer?.cancel();
    //       }
    //     });
    //     setState(() {
    //       patientID = data;
    //     });
    //   }
    // });
  }

  SingingCharacter? _character = SingingCharacter.na;
  // ignore: non_constant_identifier_names
  Gender? _Gender = Gender.Male;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const switchbar()),
        );
        return true;
      },
      child: Scaffold(
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
            title: Center(child: Text("Lesionia")),
            backgroundColor: Color(0xFF077064),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const switchbar()),
                )
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(children: [
                    Container(
                      child: Text(
                        'Medical File Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: mfn,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: 'Enter your Medical File Number',
                            labelText: 'Medical File Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter medical file number';
                          else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'First Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: firstname,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: 'Enter Patient"s First Name',
                            labelText: 'First Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter Patient's first name";
                          else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: lastname,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "Enter patient's Last Name",
                            labelText: 'Last Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter Patient's Last Name";
                          else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Birth Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}"),
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () {
                        _pickDate(context);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Age',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (pickedDate.year == 1900)
                      ListTile(
                        title: Center(
                            child: Text(
                          "${-1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    if (pickedDate.year != 1900)
                      ListTile(
                        title: Center(
                            child: Text("${dateNow.year - pickedDate.year}",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Nationality',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: nationality,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "Enter Patient's Nationality",
                            labelText: 'Nationality'),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter patient's Nationality";
                          else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Gender',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          RadioListTile(
                              title: Text('Male'),
                              value: Gender.Male,
                              groupValue: _Gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _Gender = value;
                                  gender = "Male";
                                });
                              }),
                          RadioListTile(
                              title: Text('Female'),
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
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Consent',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                            Text('Yes')
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
                            Text('No')
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
                            Text('N/A')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: phone,
                        maxLength: 8,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green)),
                            hintText: "Enter Patient's Phone Number",
                            labelText: "Phone Number"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter patient's Phone Number";
                          else if (value.length < 8) {
                            return "Enter Atleast 8 numbers";
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                          );
                         await Patient_Serivce.SavePatient(
                              mfn.text,
                              firstname.text,
                              lastname.text,
                              correctlyFormattedDateTime(pickedDate),
                             CorrectlyDateTimeToInt(dateNow, pickedDate),
                             nationality.text,
                             gender,
                             consent,
                            phone.text,
                            context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 30, top: 30),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                (new Color(0xFF6DD6CA)),
                                new Color(0xff088274)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
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
                          "Save",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                )),
          )),
    );
  }

  _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      locale: const Locale('fr', 'FR'),
      fieldHintText: 'dd/mm/yyyy',
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: DateTime(DateTime.now().year + 5),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );

    if (date != null && date != pickedDate) {
      setState(() {
        pickedDate = date;
      });
    }
  }
}

String correctlyFormattedDateTime(DateTime date) {
  if (date.month.toString().length == 1 && date.day.toString().length == 1) {
    return '${date.year}-0${date.month}-0${date.day}';
  } else if (date.day.toString().length == 1) {
    return '${date.year}-${date.month}-0${date.day}';
  } else if (date.month.toString().length == 1) {
    return '${date.year}-0${date.month}-${date.day}';
  } else
    return '${date.year}-${date.month}-${date.day}';
}

// ignore: non_constant_identifier_names
int CorrectlyDateTimeToInt(DateTime date1, DateTime date2) {
  if (date2.year == 1900) {
    return -1;
  } else
    return date1.year - date2.year;
}
