import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_lesionia_project/widgets/navigation_drawer_widget.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  // ignore: non_constant_identifier_names
  final PatientID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
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
                '/patients',
              )
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(right: 210),
                child: Text(
                  'Patient ID',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 21),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: TextFormField(
                    controller: PatientID,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: 'Enter your Patient ID',
                        labelText: 'Patient ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your ID';
                      else {
                        if (PatientID.text.length <= 10)
                          return null;
                        else if (PatientID.text.length > 10)
                          return 'PatientID should be Maximum 10 numbers';
                      }
                    }),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (
                      BuildContext contextt,
                    ) {
                      return CupertinoAlertDialog(
                        title: const Text('Verify Patient ID'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Are you sure that Patients ID is ' +
                                  PatientID.text +
                                  ' ?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              Navigator.pop(contextt);
                              Navigator.pushReplacementNamed(
                                  context, '/addpatient',
                                  arguments: {'patientid': PatientID.text});
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
                    gradient: LinearGradient(colors: [
                      (new Color(0xFF6DD6CA)),
                      new Color(0xff088274)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
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
                    "NEXT",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // RaisedButton(
              //   color: Color(0xFF838eaa),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16)),
              //   child: SizedBox(
              //       width: 100,
              //       height: 25,
              //       child: Text(
              //         'Next',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //         ),
              //       )),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       barrierDismissible: false, // user must tap button!
              //       builder: (
              //         BuildContext contextt,
              //       ) {
              //         return CupertinoAlertDialog(
              //           title: const Text('Verify Patient ID'),
              //           content: SingleChildScrollView(
              //             child: ListBody(
              //               children: <Widget>[
              //                 Text('Are you sure that Patients ID is ' +
              //                     PatientID.text +
              //                     ' ?'),
              //               ],
              //             ),
              //           ),
              //           actions: <Widget>[
              //             TextButton(
              //               child: const Text('Yes'),
              //               onPressed: () {
              //                 Navigator.pop(contextt);
              //                 Navigator.pushReplacementNamed(
              //                     context, '/addpatient',
              //                     arguments: {'patientid': PatientID.text});
              //               },
              //             ),
              //             TextButton(
              //               child: const Text('No'),
              //               onPressed: () {
              //                 Navigator.pop(contextt);
              //               },
              //             )
              //           ],
              //         );
              //       },
              //     );
              //   },
              // ),
            ])));
  }
}
