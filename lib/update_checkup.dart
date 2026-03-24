import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/widgets/AllLists.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:new_lesionia_project/widgets/otherFunction.dart';

class update_checkup extends StatefulWidget {
  const update_checkup({Key? key}) : super(key: key);

  @override
  _update_checkupState createState() => _update_checkupState();
}

class _update_checkupState extends State<update_checkup> {
  late DateTime pickedDate;
  late DateTime dateNow;
  var number = TextEditingController();
  var hospital = TextEditingController();
  var physician = TextEditingController();
  var sampler = TextEditingController();
  var other1 = TextEditingController();
  var other2 = TextEditingController();

  List animalList = [];
  List clinicalList = [];
  List humanList = [];
  List linkhumanlist = [];
  List lesioniaposList = [];
  String send = '';
  String send1 = '';
  String send2 = '';
  String send3 = '';
  String send4 = '';
  String animal = '';
  String clinicalState = '';
  String humanhost = '';
  String humanlink = '';
  String lesioniaPos = '';
  var data;
  Timer? _timer;
  List<String> editing = [];
  List<String> selectedanimal = [];
  List<String> selectedstate = [];
  List<String> selectedhumanhost = [];
  List<String> selectedhumanlink = [];
  List<String> selectedlesioniaPos = [];
  bool isEdited = false;
  var bb;
  var idcheckup;

  @override
  void initState() {
    super.initState();
    sampler.addListener(() {
      setState(() {
        editing.add(sampler.value.text);
        isEdited = true;
      });
    });
    pickedDate = DateTime.now();
    dateNow = DateTime.now();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      idcheckup = await AuthService.getCheckupID();
      data = await Checkup_Service.getcheckupbyid(context);
      if (data != null) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        reloadDATA();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/checkup');
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
          title: Center(child: Text("$idcheckup")),
          backgroundColor: Color(0xFF077064),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/checkup');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                buildTextField("Hospital", "Enter your Hospital name", hospital),
                buildTextField("Physician", "Enter Physician", physician),
                buildTextField("Sampler", "Enter Sampler", sampler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Sampler";
                      }
                      return null;
                    }),
                buildDatePicker(),
                buildDropdownMulti(
                    "Clinical State",
                    listToSearchCS.map((e) => e['name'] as String).toList(),
                    selectedstate, (List<String> values) {
                  setState(() {
                    selectedstate = values;
                    send = selectedstate.join(",");
                  });
                }, otherController: other1),
                buildDropdownMulti(
                    "Surrounding Human Cases",
                    listToSearchSHC.map((e) => e['name'] as String).toList(),
                    selectedhumanhost, (List<String> values) {
                  setState(() {
                    selectedhumanhost = values;
                    send1 = selectedhumanhost.join(",");
                  });
                }),
                buildDropdownMulti(
                    "Link with Human Cases",
                    listToSearchLHC.map((e) => e['name'] as String).toList(),
                    selectedhumanlink, (List<String> values) {
                  setState(() {
                    selectedhumanlink = values;
                    send2 = selectedhumanlink.join(",");
                  });
                }),
                buildDropdownMulti(
                    "Possible Animal Contact",
                    listToSearchPAC.map((e) => e['name'] as String).toList(),
                    selectedanimal, (List<String> values) {
                  setState(() {
                    selectedanimal = values;
                    send3 = selectedanimal.join(",");
                  });
                }, otherController: other2),
                buildTextField("Number of lesions", "Number of lesions", number,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                buildDropdownMulti(
                    "Lesion localisation",
                    listToSearchLL.map((e) => e['name'] as String).toList(),
                    selectedlesioniaPos, (List<String> values) {
                  setState(() {
                    selectedlesioniaPos = values;
                    send4 = selectedlesioniaPos.join(",");
                  });
                }),
                buildUpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController ctrl,
      {TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
        SizedBox(height: 20),
        TextFormField(
          controller: ctrl,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.green)),
              hintText: hint,
              labelText: label),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Medical check-up date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
        ListTile(
          title: Center(
            child:
            Text("${pickedDate.day}-${pickedDate.month}-${pickedDate.year}"),
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () {
            _pickDate(context);
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget buildDropdownMulti(String label, List<String> items,
      List<String> selectedItems, Function(List<String>) onChanged,
      {TextEditingController? otherController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
        SizedBox(height: 20),
        DropdownSearch<String>.multiSelection(
          items: items,
          selectedItems: selectedItems,
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
          onChanged: (values) {
            onChanged(values);
          },
        ),
        if (selectedItems.contains("Other") && otherController != null) ...[
          SizedBox(height: 20),
          TextFormField(
            controller: otherController,
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
      ],
    );
  }

  Widget buildUpdateButton() {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext contextt) {
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
                    await Checkup_Service.updateCheckup(
                        hospital.text,
                        physician.text,
                        sampler.text,
                        correctlyFormattedDateTime(pickedDate),
                        OtherFunction(send, other1.text),
                        send1,
                        send2,
                        OtherFunction(send3, other2.text),
                        stringtoint(number.text),
                        send4,
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
            BoxShadow(offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
          ],
        ),
        child: Text(
          "UPDATE",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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

    if (date != null && date != pickedDate) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  reloadDATA() {
    setState(() {
      animal = data['animal_AROUND'];
      animalList = animal.split(',');
      String cc = listToSearchPAC1.join(",");
      animalList.forEach((element) {
        if (!cc.contains(element)) {
          var otherContent2 = animalList.last;
          other2.text = otherContent2;
          animalList.remove(animalList.last);
          animalList.add('Other');
        }
      });
      selectedanimal = List<String>.from(animalList);

      clinicalState = data['clinical_STATE'];
      clinicalList = clinicalState.split(',');
      String aa = listToSearchCS1.join(",");
      clinicalList.forEach((element) {
        if (!aa.contains(element)) {
          var otherContent = clinicalList.last;
          other1.text = otherContent;
          clinicalList.remove(clinicalList.last);
          clinicalList.add('Other');
        }
      });
      selectedstate = List<String>.from(clinicalList);

      humanhost = data['possible_HUMAN_HOSTS'];
      humanList = humanhost.split(',');
      selectedhumanhost = List<String>.from(humanList);

      humanlink = data['link_HUMAN_HOSTS'];
      linkhumanlist = humanlink.split(',');
      selectedhumanlink = List<String>.from(linkhumanlist);

      lesioniaPos = data['lesposss'];
      lesioniaposList = lesioniaPos.split(',');
      selectedlesioniaPos = List<String>.from(lesioniaposList);

      if (data['hospital'] != null) hospital.text = data['hospital'];
      if (data['physician'] != null) physician.text = data['physician'];
      if (data['sampler'] != null) sampler.text = data['sampler'];
      number.text = data['lesnum'].toString();
      pickedDate = DateTime.parse(data['date_MED']);

      send = clinicalList.join(",");
      send1 = humanhost;
      send2 = humanlink;
      send3 = animalList.join(",");
      send4 = lesioniaPos;
    });
  }
}

int stringtoint(num) {
  return int.parse(num.toString());
}
