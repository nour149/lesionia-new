import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lesionia_project/services/treatment_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/TestCustom.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';

class add_treatment_history extends StatefulWidget {
  const add_treatment_history({Key? key}) : super(key: key);

  @override
  State<add_treatment_history> createState() => _add_treatment_historyState();
}

enum prescribed { other, leishmania, na }

class _add_treatment_historyState extends State<add_treatment_history> {
  String send = "";
  String prescribedfor = "";
  List selectedList = [];
  var number = TextEditingController();
  var other = TextEditingController();
  var other2 = TextEditingController();
  var numberofinjection = TextEditingController();
  var posology = TextEditingController();
  var adminroot = TextEditingController();
  prescribed? _prescribed = prescribed.na;
  late DateTime pickedDate;
  late DateTime pickedDate2;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.parse('1900-01-01');
    pickedDate2 = DateTime.parse('1900-01-01');
    setState(() {
      number.text = "-1";
      numberofinjection.text = "-1";
      prescribedfor = "N/A";
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/treatmenthistory');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff088274), Colors.greenAccent],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          title: Center(child: Text("Lesionia")),
          backgroundColor: Color(0xFF077064),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/treatmenthistory');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(children: [
              Text(
                'Historical Treatment Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchableDropDown2(
                  initialIndex: 0,
                  items: listToSearchHTT,
                  label: 'Historical Treatment',
                  multiSelectTag: 'Historical Treatment',
                  multiSelectValuesAsWidget: true,
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                  multiSelect: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.search),
                  ),
                  labelStyle: TextStyle(fontSize: 18),
                  dropdownItemStyle: TextStyle(height: 2, fontSize: 25),
                  dropDownMenuItems: listToSearchHTT.map((item) {
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
              if (send.contains('Other')) ...[
                SizedBox(height: 15),
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
                'Prescribed for',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio<prescribed>(
                          value: prescribed.leishmania,
                          groupValue: _prescribed,
                          onChanged: (prescribed? value) {
                            setState(() {
                              _prescribed = value;
                              prescribedfor = 'Leishmania';
                            });
                          }),
                      Text('Leishmania',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: prescribed.other,
                          groupValue: _prescribed,
                          onChanged: (prescribed? value) {
                            setState(() {
                              _prescribed = value;
                              prescribedfor = "Other";
                            });
                          }),
                      Text('Other',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: prescribed.na,
                          groupValue: _prescribed,
                          onChanged: (prescribed? value) {
                            setState(() {
                              _prescribed = value;
                              prescribedfor = 'N/A';
                            });
                          }),
                      Text('N/A',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
              if (prescribedfor.contains('Other')) ...[
                SizedBox(height: 15),
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
              SizedBox(height: 20),
              Text(
                'Treatment start date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
              SizedBox(height: 15),
              Text(
                'Healing date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              ListTile(
                title: Center(
                  child: Text(
                      "${pickedDate2.day}-${pickedDate2.month}-${pickedDate2.year}"),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () {
                  _pickDate2(context);
                },
              ),
              SizedBox(height: 15),
              Text(
                'Treatment Duration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                  hintText: "Number of Weeks",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 20),
              Text(
                'Posology',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: posology,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.green)),
                  hintText: "Posology",
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Administration Root',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: adminroot,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.green)),
                  hintText: "Enter Administration Root",
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Number of injections',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: numberofinjection,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.green)),
                  hintText: "Number of Weeks",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              GestureDetector(
                onTap: () async {
                  await Treatment_Service.saveTreatmentHistory(
                      OtherFunction(send, other.text),
                      OtherFunction2(prescribedfor, other2.text),
                      correctlyFormattedDateTime(pickedDate),
                      correctlyFormattedDateTime(pickedDate2),
                      number.text,
                      posology.text,
                      adminroot.text,
                      numberofinjection.text,
                      context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 30, top: 30),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF6DD6CA), Color(0xff088274)],
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

  _pickDate2(BuildContext context) async {
    final date = await showDatePicker(
      locale: const Locale('fr', 'FR'),
      fieldHintText: 'dd/mm/yyyy',
      context: context,
      initialDate: pickedDate2,
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: DateTime(DateTime.now().year + 5),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    if (date != null)
      setState(() {
        pickedDate2 = date;
      });
  }

  double stringtofloat(String num) {
    return double.parse(num);
  }
}