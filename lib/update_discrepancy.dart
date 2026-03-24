import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/checkup_service.dart';
import 'package:new_lesionia_project/services/discrepancy_service.dart';

// ignore: camel_case_types
class update_discrepancy extends StatefulWidget {
  const update_discrepancy({Key? key}) : super(key: key);

  @override
  State<update_discrepancy> createState() => _update_discrepancyState();
}

// ignore: camel_case_types
class _update_discrepancyState extends State<update_discrepancy> {
  final _formKey = GlobalKey<FormState>();
  var desc = TextEditingController();
  String iddiscrepancy = "";
  var checkupDATES = [];
  String? value;
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
    var data2;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      iddiscrepancy = await AuthService.getDiscrepancyID();
      data = await Checkup_Service.getallcheckupsdate(context);
      data2 = await Discrepancy_Service.getdiscrepancybyid(context);
      if (data != null && data2 != null) {
        setState(() {
          value = data2['datemed'];
          desc.text = data2['description'];
          checkupDATES = data;
        });
      }
    });
  }

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
            title: Center(child: Text("$iddiscrepancy")),
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
                                      await Discrepancy_Service
                                          .updateDiscrepancy(
                                              value, desc.text, context);
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
}
