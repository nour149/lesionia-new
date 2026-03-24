import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/myuser_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/TestCustom.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';

// ignore: camel_case_types
class add_checkup extends StatefulWidget {
  const add_checkup({Key? key}) : super(key: key);

  @override
  _add_checkupState createState() => _add_checkupState();
}

// ignore: camel_case_types
class _add_checkupState extends State<add_checkup> {
  var number = TextEditingController();
  var hospital = TextEditingController();
  var physician = TextEditingController();
  var sampler = TextEditingController();
  var other1 = TextEditingController();
  var other2 = TextEditingController();
  late DateTime pickedDate;
  late DateTime dateNow;
  List selectedList = [];
  List selectedList2 = [];
  List selectedList3 = [];
  List selectedList4 = [];
  List selectedList5 = [];
  String send = '';
  String send1 = '';
  String send2 = '';
  String send3 = '';
  String send4 = '';
  String hos = '';
  bool isEdited = false;
  var data;
  var dataa;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    sampler.addListener(() {
      setState(() {
        isEdited = true;
      });
    });
    pickedDate = DateTime.now();
    dateNow = DateTime.now();
    setState(() {
      number.text = "-1";
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Myuser_Service.getmyUserdetail(context);
      dataa = await Myuser_Service.getUser(context);
      if (data != null && dataa != null) {
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          hospital.text = data['frominst'];
          physician.text = dataa['first_NAME_INTERROGATOR'] +
              ' ' +
              dataa['last_NAME_INTERROGATOR'];
        });
      }
    });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Discard Changes?'),
            content: Text('Changes on this page will not be saved !'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        '/checkup',
                      ),
                  child: Text("Discard"))
            ],
          ));
  @override
  Widget build(BuildContext context) {
    int num = int.parse(number.text);
    return WillPopScope(
      onWillPop: () async {
        if (isEdited) {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        } else {
          Navigator.pushReplacementNamed(
            context,
            '/checkup',
          );
          return true;
        }
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
                  '/checkup',
                )
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Hospital',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: hospital,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: 'Enter your Hospital name',
                        labelText: 'Hospital Name'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Physician',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: physician,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: 'Enter Physician',
                        labelText: 'Physician'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Sampler',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: sampler,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)),
                          hintText: "Enter Sampler",
                          labelText: 'Sampler'),
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
                      'Medical check-up date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                      'Clinical State',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchableDropDown2(
                      initialIndex: 0,
                      items: listToSearchCS,
                      label: 'Select State',
                      multiSelectTag: 'Clinical State',
                      multiSelectValuesAsWidget: true,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      multiSelect: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Icon(Icons.search),
                      ),
                      labelStyle: TextStyle(fontSize: 18),
                      dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                      dropDownMenuItems: listToSearchCS.map((item) {
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
                        } else {
                          setState(() {
                            selectedList.clear();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (send.contains('Other'))
                    Container(
                      child: Text(
                        'if other please specify',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                  if (send.contains('Other'))
                    SizedBox(
                      height: 20,
                    ),
                  if (send.contains('Other'))
                    TextFormField(
                      controller: other1,
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
                      'surrounding human cases',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchableDropDown2(
                      initialIndex: 0,
                      items: listToSearchSHC,
                      label: 'Select surrounding human cases',
                      multiSelectTag: 'surrounding human cases',
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
                      dropDownMenuItems: listToSearchSHC.map((item) {
                        return item['name'];
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedList2 = jsonDecode(value);
                          });

                          send1 = '';
                          selectedList2.forEach((element) {
                            setState(() {
                              if (send1 == '') {
                                send1 = element['name'];
                              } else {
                                send1 = send1 + ',' + element['name'];
                              }
                            });
                          });
                        } else {
                          selectedList2.clear();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Link with human cases',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchableDropDown2(
                      initialIndex: 0,
                      items: listToSearchLHC,
                      label: 'Select human cases',
                      multiSelectTag: 'Link with human cases',
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
                      dropDownMenuItems: listToSearchLHC.map((item) {
                        return item['name'];
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedList3 = jsonDecode(value);
                          send2 = '';
                          selectedList3.forEach((element) {
                            if (send2 == '') {
                              send2 = element['name'];
                            } else {
                              send2 = send2 + ',' + element['name'];
                            }
                          });
                        } else {
                          selectedList3.clear();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Possible animal contact',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchableDropDown2(
                      initialIndex: 0,
                      items: listToSearchPAC,
                      label: 'Select animal',
                      multiSelectTag: 'animal contact',
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
                      dropDownMenuItems: listToSearchPAC.map((item) {
                        return item['name'];
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedList4 = jsonDecode(value);
                          });
                          send3 = '';
                          selectedList4.forEach((element) {
                            setState(() {
                              if (send3 == '') {
                                send3 = element['name'];
                              } else {
                                send3 = send3 + ',' + element['name'];
                              }
                            });
                          });
                        } else {
                          selectedList4.clear();
                        }
                      },
                    ),
                    // CustomSearchableDropDown(
                    //   items: listToSearchPAC,
                    //   label: 'Select animal',
                    //   multiSelectTag: 'animal contact',
                    //   multiSelectValuesAsWidget: true,
                    //   showClearButton: true,
                    //   decoration:
                    //       BoxDecoration(border: Border.all(color: Colors.blue)),
                    //   multiSelect: true,
                    //   labelStyle: TextStyle(fontSize: 18),
                    //   dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                    //   prefixIcon: Padding(
                    //     padding: const EdgeInsets.all(0.0),
                    //     child: Icon(Icons.search),
                    //   ),
                    //   dropDownMenuItems: listToSearchPAC.map((item) {
                    //     return item['name'];
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       setState(() {
                    //         selectedList4 = jsonDecode(value);
                    //       });
                    //       send3 = '';
                    //       selectedList4.forEach((element) {
                    //         setState(() {
                    //           if (send3 == '') {
                    //             send3 = element['name'];
                    //           } else {
                    //             send3 = send3 + ' ' + element['name'];
                    //           }
                    //         });
                    //       });
                    //     } else {
                    //       selectedList4.clear();
                    //     }
                    //   },
                    // ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (send3.contains('Other'))
                    Container(
                      child: Text(
                        'if other please specify',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                  if (send3.contains('Other'))
                    SizedBox(
                      height: 20,
                    ),
                  if (send3.contains('Other'))
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
                  SizedBox(height: 15),
                  Container(
                    child: Text(
                      'number of lesions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.green)),
                      hintText: "Number of lesions",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Text(
                      'Lesion localisation',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchableDropDown2(
                      initialIndex: 0,
                      items: listToSearchLL,
                      label: 'Select localisation',
                      multiSelectTag: 'Lesion localisation',
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
                      dropDownMenuItems: listToSearchLL.map((item) {
                        return item['name'];
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedList5 = jsonDecode(value);
                          send4 = '';
                          selectedList5.forEach((element) {
                            if (send4 == '') {
                              send4 = element['name'];
                            } else {
                              send4 = send4 + ',' + element['name'];
                            }
                          });
                        } else {
                          selectedList5.clear();
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Checkup_Service.saveCheckup(
                          hospital.text,
                          physician.text,
                          sampler.text,
                          correctlyFormattedDateTime(pickedDate),
                          OtherFunction(send, other1.text),
                          send1,
                          send2,
                          OtherFunction(send3, other2.text),
                          num,
                          send4,
                          context);
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
}
