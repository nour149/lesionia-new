import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/diagnosis_service.dart';
import 'package:new_lesionia_project/services/moleculartest_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:new_lesionia_project/services/suspectedspecies_service.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';

// ignore: camel_case_types
class add_diagnosis extends StatefulWidget {
  const add_diagnosis({Key? key}) : super(key: key);

  @override
  State<add_diagnosis> createState() => _add_diagnosisState();
}

enum TestResult { positive, negative, na }

// ignore: camel_case_types
class _add_diagnosisState extends State<add_diagnosis> {
  final _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();
  late DateTime pickedDate;
  @override
  void initState() {
    var data;
    var data2;
    var data3;
    var data4;
    String patientId = "";
    setState(() {
    });
    quantity.text = "-1";

    super.initState();
    pickedDate = DateTime.now();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await DiagnosisService.getLaboratory(context);
      data2 = await Sample_Service.getSampleID(context);
      data3 = await MolecularTest_Service.getalltests(context);
      data4 = await SuspectedSpecies_Service.getallspecies(context);
      if (data != null && data2 != null && data3 != null && data4 != null) {
        setState(() {
          laboratory = data;
          idsample = data2;
          molecular_test = data3;
          suspected_species = data4;
        });
      }
    });
  }

  var laboratory = [];
  var idsample = [];
  // ignore: non_constant_identifier_names
  var suspected_species = [];
  // ignore: non_constant_identifier_names
  var molecular_test = [];
  String testresult = "N/A";
  String? value;
  String? value2;
  String? value3;
  String? value4 = "N/A";
  TestResult? _testresult = TestResult.na;
  @override
  Widget build(BuildContext context) {
    int num = int.parse(quantity.text);
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
            title: Center(child: Text("Lesionia")),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  height: 1, fontWeight: FontWeight.bold),
                            ),
                            value: value,
                            iconSize: 36,
                            isExpanded: true,
                            hint: Center(
                                child: Text(
                              "Select molecular test",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            validator: (value) =>
                                value == null ? '*Fill in this field !' : null,
                            items: molecular_test.map((item) {
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
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  height: 1, fontWeight: FontWeight.bold),
                            ),
                            value: value2,
                            iconSize: 36,
                            isExpanded: true,
                            hint: Center(
                                child: Text(
                              "Select laboratory",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            validator: (value) =>
                                value == null ? '*Fill in this field !' : null,
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
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                height: 1, fontWeight: FontWeight.bold),
                          ),
                          hint: Center(
                              child: Text(
                            "Select id sample",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          value: value3,
                          iconSize: 36,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Choose an id to add !' : null,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Fill in this field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(height: 1, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: "DNA volume (in microL)*",
                      ),
                      inputFormatters: [
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
                                    testresult = '+';
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
                                    testresult = '-';
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
                                    testresult = 'N/A';
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
                    if (testresult == "+")
                      Container(
                        child: Text(
                          'Suspected Species',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                      ),
                    if (testresult == "+") SizedBox(height: 20),
                    if (testresult == "+")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 4)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    height: 1, fontWeight: FontWeight.bold),
                              ),
                              value: value4,
                              iconSize: 36,
                              isExpanded: true,
                              validator: (value) => value == null
                                  ? '*Fill in this field !'
                                  : null,
                              items: suspected_species.map((item) {
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
                          DiagnosisService.saveDiagnosis(
                              value,
                              value2,
                              value3,
                              correctlyFormattedDateTime(pickedDate),
                              num,
                              testresult,
                              suspectedSpecies(testresult, value4),
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
                  ])),
            ),
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
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  String? suspectedSpecies(testresult, value4) {
    if (testresult == "+") {
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
