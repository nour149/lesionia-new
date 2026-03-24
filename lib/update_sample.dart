import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/TestCustom.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';

// ignore: camel_case_types
class update_sample extends StatefulWidget {
  const update_sample({Key? key}) : super(key: key);

  @override
  State<update_sample> createState() => _update_sampleState();
}

// ignore: camel_case_types
class _update_sampleState extends State<update_sample> {
  late DateTime pickedDate;
  final _formKey = GlobalKey<FormState>();
  var bb;
  var other = TextEditingController();
  var other2 = TextEditingController();
  var other3 = TextEditingController();
  var age = TextEditingController();
  var max = TextEditingController();
  var min = TextEditingController();
  var height = TextEditingController();
  String? value;
  String? value2;
  String? value3;
  String? value4;
  String send = "";
  String send2 = "";
  String send3 = "";
  String send4 = "";
  String desc = "";
  String type = "";
  String sampling = "";
  String localisation = "";
  List selectedList = [];
  List selectedListt = [];
  List desclist = [];
  List selectedList2 = [];
  List selectedListt2 = [];
  List typelist = [];
  List selectedList3 = [];
  List selectedListt3 = [];
  List samplinglist = [];
  List selectedList4 = [];
  List selectedListt4 = [];
  List localisationlist = [];
  var checkupDATES = [];
  int currentStep = 0;
  var data;
  String idsample = "";
  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    var data2;
    super.initState();
    pickedDate = DateTime.now();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      idsample = await AuthService.getSampleID();
      data = await Sample_Service.getsamplebyid(context);
      data2 = await Checkup_Service.getallcheckupsdate(context);

      if (data != null && data2 != null) {
        // EasyLoading.addStatusCallback((status) {
        //   print('EasyLoading Status $status');
        //   if (status == EasyLoadingStatus.dismiss) {
        //     _timer?.cancel();
        //   }
        // });
        setState(() {
          checkupDATES = data2;
        });

        reloadDATA();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => {
              Navigator.pushReplacementNamed(
                context,
                '/sample',
              )
            },
          ),
          title: Center(child: Text("$idsample")),
          backgroundColor: Color(0xFF077064),
        ),
        body: Theme(
          data: Theme.of(context)
              .copyWith(colorScheme: ColorScheme.light(primary: Colors.green)),
          child: Form(
            key: _formKey,
            child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
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
                                  await Sample_Service.updateSample(
                                      OtherFunction(send, other.text),
                                      stringtofloat(age.text) as double,
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
                                      context );
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
                  } else {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        currentStep += 1;
                      }
                    });
                  }
                },
                onStepTapped: (step) => setState(() => currentStep = step),
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
                        if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: Text('BACK'),
                              onPressed: details.onStepCancel,
                            ),
                          ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(isLastStep ? 'UPDATE' : 'NEXT'),
                            onPressed: details.onStepContinue,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSearchableDropDown2(
                    initialIndex: 0,
                    initialValue: selectedListt,
                    items: listToSearchDL,
                    label: 'Select Lesionia Description',
                    multiSelectTag: 'Lesionia Description',
                    multiSelectValuesAsWidget: true,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
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
                        selectedListt.clear();

                        selectedList.forEach((element) {
                          bb = {
                            'parameter': 'name',
                            'value': element['name'],
                          };
                          setState(() {
                            selectedListt.add(bb);
                          });
                        });
                      } else {
                        setState(() {
                          selectedList.clear();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (send.contains('Other'))
                  Container(
                    child: Text(
                      'if other please specify',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                if (send.contains('Other'))
                  SizedBox(
                    height: 20,
                  ),
                if (send.contains('Other'))
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'Type of sample support',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSearchableDropDown2(
                    initialIndex: 0,
                    initialValue: selectedListt2,
                    items: listToSearchSS,
                    label: 'Select Type of sample',
                    multiSelectTag: 'Type of sample support',
                    multiSelectValuesAsWidget: true,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
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
                        selectedListt2.clear();

                        selectedList2.forEach((element) {
                          bb = {
                            'parameter': 'name',
                            'value': element['name'],
                          };

                          selectedListt2.add(bb);
                        });
                      } else {
                        selectedList2.clear();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (send2.contains('Other'))
                  Container(
                    child: Text(
                      'if other please specify',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                if (send2.contains('Other'))
                  SizedBox(
                    height: 20,
                  ),
                if (send2.contains('Other'))
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'Sampling Method',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSearchableDropDown2(
                    initialIndex: 0,
                    initialValue: selectedListt3,
                    items: listToSearchSM,
                    label: 'Select Sampling Method',
                    multiSelectTag: 'Sampling Method',
                    multiSelectValuesAsWidget: true,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
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
                        selectedListt3.clear();

                        selectedList3.forEach((element) {
                          bb = {
                            'parameter': 'name',
                            'value': element['name'],
                          };
                          selectedListt3.add(bb);
                        });
                      } else {
                        selectedList3.clear();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (send3.contains('Other'))
                  Container(
                    child: Text(
                      'if other please specify',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                if (send3.contains('Other'))
                  SizedBox(
                    height: 20,
                  ),
                if (send3.contains('Other'))
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'Direct examination result',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                        items: examinationResult.map((item) {
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
                    'Abundance on the smear',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                        value: value2,
                        iconSize: 36,
                        isExpanded: true,
                        items: abundanceonthesmear.map((item) {
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
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Part 2'),
            content: Column(
              children: [
                Container(
                  child: Text(
                    'Lesion first appearence',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                    'Or lesion age(in weeks)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
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
                    // ignore: deprecated_member_use
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'lesion Diameter Maximal(millimeter)*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
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
                    // ignore: deprecated_member_use
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'lesion Diameter Minimal(millimeter)*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
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
                    // ignore: deprecated_member_use
                    FilteringTextInputFormatter.allow((RegExp(r'^\d+\.?\d{0,2}'))),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'lesion Height(millimeter)*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
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
                    // ignore: deprecated_member_use
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    'Sampling date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 5,
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
                        return new DropdownMenuItem(
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    'Lesion Site Sampled',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 5,
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
                        return new DropdownMenuItem(
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    'Localisation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSearchableDropDown2(
                    initialValue: selectedListt4,
                    items: lesioniaSite,
                    label: 'Select Localisation',
                    multiSelectTag: 'Localisation',
                    multiSelectValuesAsWidget: true,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
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
                          selectedListt4.add(bb);
                        });
                      } else {
                        selectedList4.clear();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text('Complete'),
            content: Container())
      ];
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

  reloadDATA() {
    setState(() {
      desc = data['description'];
      desclist = desc.split(',');
      String cc = listToSearchDL1.join(",");
      desclist.forEach((element) {
        if (cc.contains(element) == false) {
          setState(() {
            var otherContent = desclist.last;
            other.text = otherContent;
            print(otherContent);
            desclist.remove(desclist.last);
            desclist.add('Other');
          });
        }
      });

      desclist.forEach((element) {
        bb = {
          'parameter': 'name',
          'value': element,
        };
        selectedListt.add(bb);
      });

      type = data['type_OF_SAMPLE_SUPPORT_'];
      typelist = type.split(',');
      String aa = listToSearchSS1.join(",");
      typelist.forEach((element) {
        if (aa.contains(element) == false) {
          setState(() {
            var otherContent2 = typelist.last;
            other2.text = otherContent2;
            print(otherContent2);
            typelist.remove(typelist.last);
            typelist.add('Other');
          });
        }
      });
      typelist.forEach((element) {
        bb = {
          'parameter': 'name',
          'value': element,
        };
        selectedListt2.add(bb);
      });

      sampling = data['sampling_METHOD'];
      samplinglist = sampling.split(',');
      String dd = listToSearchSM1.join(",");
      samplinglist.forEach((element) {
        if (dd.contains(element) == false) {
          setState(() {
            var otherContent3 = samplinglist.last;
            other3.text = otherContent3;
            print(otherContent3);
            samplinglist.remove(samplinglist.last);
            samplinglist.add('Other');
          });
        }
      });
      samplinglist.forEach((element) {
        bb = {
          'parameter': 'name',
          'value': element,
        };
        selectedListt3.add(bb);
      });
      if (data['localisation'] != null &&
          data['localisation'] != '' &&
          data['localisation'] != 'null') {
        localisation = data['localisation'];
        localisationlist = localisation.split(',');

        localisationlist.forEach((element) {
          bb = {
            'parameter': 'name',
            'value': element,
          };
          selectedListt4.add(bb);
        });
      }
      value = data['direct_EXAMINATION'];
      value2 = data['abudance_ON_THE_SMEAR'];
      if (data['date_EXTRACTION'] != null &&
          data['date_EXTRACTION'] != '' &&
          data['date_EXTRACTION'] != 'null') {
        setState(() {
          value3 = data['date_EXTRACTION'];
        });
      }
      if (data['lesion_SITE_SAMPLED'] != null &&
          data['lesion_SITE_SAMPLED'] != '' &&
          data['lesion_SITE_SAMPLED'] != 'null') {
        setState(() {
          value4 = data['lesion_SITE_SAMPLED'];
        });
      }
      age.text = data['lesion_Age'].toString();
      min.text = data['diametremin'].toString();
      max.text = data['diametremax'].toString();
      height.text = data['hight'].toString();
      pickedDate = DateTime.parse(data['date_First_Apeard']);
      send = desclist.join(",");
      send2 = typelist.join(",");
      send3 = samplinglist.join(",");
      send4 = localisationlist.join(",");
    });
  }
}
