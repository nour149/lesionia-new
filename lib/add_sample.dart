import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/alliquot_service.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/TestCustom.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class add_sample extends StatefulWidget {
  const add_sample({Key? key}) : super(key: key);

  @override
  State<add_sample> createState() => _add_sampleState();
}

class _add_sampleState extends State<add_sample> {
  final _formKey = GlobalKey<FormState>();
  late DateTime pickedDate;

  @override
  void initState() {
    _loadPatientID();
    var data;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Checkup_Service.getallcheckupsdate(context);
      if (data != null) {
        setState(() {
          checkupDATES = data;
        });
      }
    });

    super.initState();
    pickedDate = DateTime.parse('1900-01-01');
    age.text = "-1";
    min.text = "-1";
    max.text = "-1";
    height.text = "-1";
    nano.text = "-1";
  }

  String idpatient = "";
  int min1 = 1;
  int max1 = 100;
  var other = TextEditingController();
  var other2 = TextEditingController();
  var other3 = TextEditingController();
  var age = TextEditingController();
  var max = TextEditingController();
  var min = TextEditingController();
  var height = TextEditingController();
  var nano = TextEditingController();
  var rak = TextEditingController();
  var position = TextEditingController();
  var idsample = TextEditingController();
  String? value = "N/A";
  String? value2 = "N/A";
  String? value3;
  String? value4;
  String? value5;
  String? value6;
  String? value7;
  String send = "";
  String send2 = "";
  String send3 = "";
  String send4 = "";
  List selectedList = [];
  List testList = [];
  List selectedList2 = [];
  List testList2 = [];
  List selectedList3 = [];
  List testList3 = [];
  List selectedList4 = [];
  List testList4 = [];
  List selectedbb = [];
  var checkupDATES = [];
  int currentStep = 0;
  var bb;
  var type = ['N/A', '+4', '-30', 'Azote', 'R80'];
  var container = [1, 2, 3, 4];
  var conserve = ['N/A', "Boite"];

  _loadPatientID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patient_id') ?? '');
    });
  }

  List<Step> getSteps() => [
    Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text('Part 1'),
        content: Column(
          children: [
            Container(
              child: Text(
                'Lesionia Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchableDropDown2(
                initialIndex: 0,
                initialValue: testList,
                items: listToSearchDL,
                label: 'Select Lesionia Description',
                multiSelectTag: 'Lesionia Description',
                multiSelectValuesAsWidget: true,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                multiSelect: true,
                labelStyle: TextStyle(fontSize: 18),
                dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: listToSearchDL.map((item) {
                  return item['name'];
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedList = jsonDecode(value);
                    });

                    send = '';
                    selectedList.forEach((element) {
                      setState(() {
                        if (send == '') {
                          send = element['name'];
                        } else {
                          send = send + ',' + element['name'];
                        }
                      });
                    });
                    selectedList.forEach((element) {
                      bb = {
                        'parameter': 'name',
                        'value': element['name'],
                      };
                      testList.add(bb);
                    });
                  } else {
                    setState(() {
                      selectedList.clear();
                    });
                  }
                },
              ),
            ),
            if (send.contains('Other')) ...[
              SizedBox(height: 10),
              Text(
                'if other please specify',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: other,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "specify something",
                    labelText: 'specify something'),
              ),
            ],
            SizedBox(height: 15),
            Text(
              'Type of sample support',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchableDropDown2(
                initialIndex: 0,
                initialValue: testList2,
                items: listToSearchSS,
                label: 'Select Type of sample',
                multiSelectTag: 'Type of sample support',
                multiSelectValuesAsWidget: true,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                multiSelect: true,
                labelStyle: TextStyle(fontSize: 18),
                dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: listToSearchSS.map((item) {
                  return item['name'];
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedList2 = jsonDecode(value);
                    });

                    send2 = '';
                    selectedList2.forEach((element) {
                      setState(() {
                        if (send2 == '') {
                          send2 = element['name'];
                        } else {
                          send2 = send2 + ',' + element['name'];
                        }
                      });
                    });
                    selectedList2.forEach((element) {
                      bb = {
                        'parameter': 'name',
                        'value': element['name'],
                      };
                      testList2.add(bb);
                    });
                  } else {
                    selectedList2.clear();
                  }
                },
              ),
            ),
            if (send2.contains('Other')) ...[
              SizedBox(height: 10),
              Text(
                'if other please specify',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: other2,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "specify something",
                    labelText: 'specify something'),
              ),
            ],
            SizedBox(height: 15),
            Text(
              'Sampling Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchableDropDown2(
                initialIndex: 0,
                initialValue: testList3,
                items: listToSearchSM,
                label: 'Select Sampling Method',
                multiSelectTag: 'Sampling Method',
                multiSelectValuesAsWidget: true,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                multiSelect: true,
                labelStyle: TextStyle(fontSize: 18),
                dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: listToSearchSM.map((item) {
                  return item['name'];
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedList3 = jsonDecode(value);
                    });

                    send3 = '';
                    selectedList3.forEach((element) {
                      setState(() {
                        if (send3 == '') {
                          send3 = element['name'];
                        } else {
                          send3 = send3 + ',' + element['name'];
                        }
                      });
                    });
                    selectedList3.forEach((element) {
                      bb = {
                        'parameter': 'name',
                        'value': element['name'],
                      };
                      testList3.add(bb);
                    });
                  } else {
                    selectedList3.clear();
                  }
                },
              ),
            ),
            if (send3.contains('Other')) ...[
              SizedBox(height: 10),
              Text(
                'if other please specify',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: other3,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "specify something",
                    labelText: 'specify something'),
              ),
            ],
            SizedBox(height: 15),
            Text(
              'Direct examination result',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                    value: value,
                    iconSize: 36,
                    isExpanded: true,
                    items: examinationResult.map((item) {
                      return DropdownMenuItem(
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
            SizedBox(height: 15),
            Text(
              'Abundance on the smear',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                    items: abundanceonthesmear.map((item) {
                      return DropdownMenuItem(
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
          ],
        )),
    Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Part 2'),
        content: Column(
          children: [
            Text(
              'Lesion first appearence',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 15),
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
            SizedBox(height: 15),
            Text(
              'Or lesion age(in weeks)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: age,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Lesion age",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            Text(
              'lesion Diameter Maximal(millimeter)*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: max,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Diameter Maximal",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            Text(
              'lesion Diameter Minimal(millimeter)*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: min,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Diameter Minimal",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            Text(
              'lesion Height(millimeter)*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: height,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Height",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            Text(
              'Sampling date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 4)),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    errorStyle:
                    TextStyle(height: 1, fontWeight: FontWeight.bold),
                  ),
                  hint: Center(
                      child: Text(
                        "Select check-up date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  value: value3,
                  iconSize: 36,
                  isExpanded: true,
                  items: checkupDATES.map((item) {
                    return DropdownMenuItem(
                      child: Center(
                        child: Text(item,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      value: item.toString(),
                    );
                  }).toList(),
                  validator: (value) =>
                  value == null ? 'Choose a date to add !' : null,
                  onChanged: (value) =>
                      setState(() => this.value3 = value!),
                ),
              ),
            ),
            Text(
              'Lesion Site Sampled',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 4)),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    errorStyle:
                    TextStyle(height: 1, fontWeight: FontWeight.bold),
                  ),
                  hint: Center(
                      child: Text(
                        "Select Lesion site",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  value: value4,
                  iconSize: 36,
                  isExpanded: true,
                  items: lesionSiteSampled.map((item) {
                    return DropdownMenuItem(
                      child: Center(
                        child: Text(item,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      value: item.toString(),
                    );
                  }).toList(),
                  validator: (value) =>
                  value == null ? 'Choose a date to add !' : null,
                  onChanged: (value) =>
                      setState(() => this.value4 = value!),
                ),
              ),
            ),
            Text(
              'Localisation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchableDropDown2(
                initialValue: testList4,
                items: lesioniaSite,
                label: 'Select Localisation',
                multiSelectTag: 'Localisation',
                multiSelectValuesAsWidget: true,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                multiSelect: true,
                labelStyle: TextStyle(fontSize: 18),
                dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: lesioniaSite.map((item) {
                  return item['name'];
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedList4 = jsonDecode(value);
                    });

                    send4 = '';
                    selectedList4.forEach((element) {
                      setState(() {
                        if (send4 == '') {
                          send4 = element['name'];
                        } else {
                          send4 = send4 + ',' + element['name'];
                        }
                      });
                    });
                    selectedList4.forEach((element) {
                      bb = {
                        'parameter': 'name',
                        'value': element['name'],
                      };
                      testList4.add(bb);
                    });
                  } else {
                    selectedList4.clear();
                  }
                },
              ),
            ),
          ],
        )),
    Step(
        isActive: currentStep >= 2,
        title: Text('Alliquot'),
        content: Column(
          children: [
            Text(
              'Sample',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 20),
            TextField(
                controller: idsample,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "Nanogramme",
                    enabled: false)),
            SizedBox(height: 15),
            Text(
              'Quantity in nanogramme',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nano,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "Nanogramme",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
                            "Select Type",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      value: value5,
                      iconSize: 36,
                      isExpanded: true,
                      items: type.map((item) {
                        return DropdownMenuItem(
                          child: Center(
                            child: Text(item,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                          value: item.toString(),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          this.value5 = value!;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Container',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
                            "Select Container",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      value: value6,
                      iconSize: 36,
                      isExpanded: true,
                      items: container.map((item) {
                        return DropdownMenuItem(
                          child: Center(
                            child: Text(item.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                          value: item.toString(),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          this.value6 = value!;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Rak',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: rak,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.green)),
                  hintText: 'Rak'),
            ),
            SizedBox(height: 15),
            Text(
              'Conserve',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
                            "Select Conserve",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      value: value7,
                      iconSize: 36,
                      isExpanded: true,
                      items: conserve.map((item) {
                        return DropdownMenuItem(
                          child: Center(
                            child: Text(item.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                          value: item.toString(),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          this.value7 = value!;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Position',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: 15),
            TextField(
              controller: position,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green)),
                hintText: 'Min 1 - Max 100',
              ),
              onChanged: (String value) {
                int x;
                try {
                  x = int.parse(value);
                } catch (error) {
                  x = min1;
                }
                if (x < min1) {
                  setState(() {
                    x = min1;
                  });
                } else if (x > max1) {
                  setState(() {
                    x = max1;
                  });
                }

                position.value = TextEditingValue(
                  text: x.toString(),
                  selection: TextSelection.fromPosition(
                    TextPosition(
                        offset: position.value.selection.baseOffset),
                  ),
                );
              },
              maxLength: 3,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 15)
          ],
        ))
  ];

  @override
  Widget build(BuildContext context) {
    print(selectedList);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/sample');
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/sample');
            },
          ),
          title: Center(child: Text("$idpatient")),
          backgroundColor: Color(0xFF077064),
        ),
        body: Theme(
          data: Theme.of(context)
              .copyWith(colorScheme: ColorScheme.light(primary: Colors.green)),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () async {
              final isLastStep = currentStep == getSteps().length - 1;
              final isSecondStep = currentStep == getSteps().length - 2;
              if (isLastStep) {
                await Alliquot_Service.saveAlliquot(
                    idsample.text,
                    stringtofloat(nano.text),
                    value5.toString(),
                    value6.toString(),
                    rak.text,
                    value7.toString(),
                    stringtoint(position.text),
                    context);
              } else if (isSecondStep) {
                var v1 = await Sample_Service.saveSample(
                    OtherFunction(send, other.text),
                    stringtofloat(age.text),
                    stringtofloat(max.text),
                    stringtofloat(min.text),
                    stringtofloat(height.text),
                    OtherFunction(send3, other3.text),
                    value3.toString(),
                    OtherFunction(send2, other2.text),
                    value2.toString(),
                    value.toString(),
                    correctlyFormattedDateTime(pickedDate),
                    value4.toString(),
                    send4,
                    context);
                setState(() {
                  idsample.text = v1;
                });
                setState(() {
                  currentStep += 1;
                });
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() {
              currentStep -= 1;
            }),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: EdgeInsets.only(),
                child: Row(
                  children: [
                    if (currentStep == 2)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('SKIP'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/sample');
                          },
                        ),
                      ),
                    if (currentStep != 0 && currentStep != 2)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('BACK'),
                          onPressed: details.onStepCancel,
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(isLastStep ? 'SAVE' : 'NEXT'),
                        onPressed: details.onStepContinue,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              );
            },
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

  double stringtofloat(String num) {
    return double.parse(num);
  }

  int stringtoint(String val) {
    if (val.isEmpty) {
      return 1;
    }
    return int.parse(val);
  }
}