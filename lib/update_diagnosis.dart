import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/diagnosis_service.dart';
import 'package:new_lesionia_project/services/moleculartest_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:new_lesionia_project/services/suspectedspecies_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';

// ignore: camel_case_types
class update_diagnosis extends StatefulWidget {
  const update_diagnosis({Key? key}) : super(key: key);

  @override
  State<update_diagnosis> createState() => _update_diagnosisState();
}

enum TestResult { negative, positive, na }

// ignore: camel_case_types
class _update_diagnosisState extends State<update_diagnosis> {
  final _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();
  String iddiagnosis = "";

  late DateTime pickedDate;
  void initState() {
    String patientId ="";
    var data;
    var data2;
    var data3;
    var data4;
    var data5;
    super.initState();
    pickedDate = DateTime.now();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      iddiagnosis = await AuthService.getDiagnosisID();
      data = await DiagnosisService.getLaboratory(context);
      data2 = await Sample_Service.getSampleID(context);
      data3 = await DiagnosisService.getDiagnosisById(context);
      data4 = await MolecularTest_Service.getalltests(context);
      data5 = await SuspectedSpecies_Service.getallspecies(context);
      if (data != null && data2 != null && data4 != null && data5 != null) {
        setState(() {
          laboratory = data;
          idsample = data2;
          molecularTest = data4;
          suspected_Species = data5;
        });
      }
      if (data3 != null) {
        setState(() {
          pickedDate = DateTime.parse(data3['diagnosisdate']);
          quantity.text = data3['quantite'].toString();
          value = data3['test'];
          value2 = data3['laboratoryname'];
          value3 = data3['idsample'];
          value4 = data3['leishsuspect'];
          result = data3['result'];
        });
        CompareData();
      }
    });
  }

  String result = "";
  var laboratory = [];
  var idsample = [];
  var molecularTest = [];
  // ignore: non_constant_identifier_names
  var suspected_Species = [];
  String? value;
  String? value2;
  String? value3;
  String? value4;
  TestResult? _testresult = TestResult.na;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/diagnosis',
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
            title: Center(child: Text("$iddiagnosis")),
            backgroundColor: Color(0xFF077064),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.pushReplacementNamed(
                  context,
                  '/diagnosis',
                )
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Column(children: [
                    Container(
                      child: Text(
                        'Molecular Test',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 4)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: value,
                            iconSize: 36,
                            isExpanded: true,
                            items: molecularTest.map((item) {
                              return new DropdownMenuItem(
                                child: Center(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                value: item.toString(),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => this.value = value!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Laboratory',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 4)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: value2,
                            iconSize: 36,
                            isExpanded: true,
                            items: laboratory.map((item) {
                              return new DropdownMenuItem(
                                child: Center(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                value: item.toString(),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => this.value2 = value!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Sample',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 4)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Center(
                                child: Text(
                              "Select id sample",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            value: value3,
                            iconSize: 36,
                            isExpanded: true,
                            items: idsample.map((item) {
                              return new DropdownMenuItem(
                                child: Center(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                                value: item.toString(),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => this.value3 = value!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Test Date',
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
                        'Quantity',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: quantity,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: "DNA volume (in microL)*",
                      ),
                      inputFormatters: [
                        // ignore: deprecated_member_use

                           FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Test Result',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio<TestResult>(
                                value: TestResult.positive,
                                groupValue: _testresult,
                                onChanged: (TestResult? value) {
                                  setState(() {
                                    _testresult = value;
                                    result = '+';
                                  });
                                }),
                            Text('+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26))
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: TestResult.negative,
                                groupValue: _testresult,
                                onChanged: (TestResult? value) {
                                  setState(() {
                                    _testresult = value;
                                    result = '-';
                                  });
                                }),
                            Text('-',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26))
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: TestResult.na,
                                groupValue: _testresult,
                                onChanged: (TestResult? value) {
                                  setState(() {
                                    _testresult = value;
                                    result = 'N/A';
                                  });
                                }),
                            Text('N/A',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (result == "+")
                      Container(
                        child: Text(
                          'Suspected Species',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                      ),
                    if (result == "+") SizedBox(height: 20),
                    if (result == "+")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: value4,
                              iconSize: 36,
                              isExpanded: true,
                              items: suspected_Species.map((item) {
                                return new DropdownMenuItem(
                                  child: Center(
                                    child: Text(item,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  value: item.toString(),
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => this.value4 = value!),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (
                              BuildContext contextt,
                            ) {
                              return CupertinoAlertDialog(
                                title: const Text('Warning !'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          "Are you sure that you want to update this information ?"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      await DiagnosisService.updateDiagnosis(
                                          value,
                                          value2,
                                          value3,
                                          correctlyFormattedDateTime(
                                              pickedDate),
                                          quantity.text,
                                          result,
                                          suspectedSpecies(result, value4),
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
                          "UPDATE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ])),
            ),
          )),
    );
  }

  // ignore: non_constant_identifier_names
  CompareData() {
    if (result == 'N/A') {
      setState(() {
        _testresult = TestResult.na;
      });
    } else if (result == '-') {
      setState(() {
        _testresult = TestResult.negative;
      });
    } else {
      setState(() {
        _testresult = TestResult.positive;
      });
    }
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
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  String? suspectedSpecies(result, value4) {
    if (result == "+") {
      return value4;
    } else {
      return "N/A";
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Center(
          child: Text(
            item,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}

double stringtoint(num) {
  return double.parse(num);
}
