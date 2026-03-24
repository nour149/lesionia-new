import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/discrepancy_service.dart';

// ignore: camel_case_types
class add_discrepancy extends StatefulWidget {
  const add_discrepancy({Key? key}) : super(key: key);

  @override
  State<add_discrepancy> createState() => _add_discrepancyState();
}

// ignore: camel_case_types
class _add_discrepancyState extends State<add_discrepancy> {
  var desc = TextEditingController();
  late DateTime pickedDate;
  void initState() {
    var data;

    super.initState();
    pickedDate = DateTime.now();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Checkup_Service.getallcheckupsdate(context);
      if (data != null) {
        print(data);
        setState(() {
          checkupDATES = data;
        });
      }
    });
  }

  var checkupDATES = [];
  final _formKey = GlobalKey<FormState>();

  String? value;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/discrepancy',
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
                  '/discrepancy',
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
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: desc,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Type something here',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in this field !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Check-ups-DATE',
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
                            "Select check-up date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          value: value,
                          iconSize: 36,
                          isExpanded: true,
                          items: checkupDATES.map((item) {
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
                          validator: (value) =>
                              value == null ? 'Choose a date to add !' : null,
                          onChanged: (value) =>
                              setState(() => this.value = value!),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date Discrepancy',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: pickedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != pickedDate) {
                          setState(() {
                            pickedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${pickedDate.toLocal()}".split(' ')[0], // format like YYYY-MM-DD
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await Discrepancy_Service.saveDiscrepancy(
                              desc.text, value, value, context);
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
}
