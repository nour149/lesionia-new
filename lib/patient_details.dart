import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:new_lesionia_project/switchbar.dart';
import 'package:new_lesionia_project/widgets/FloatingNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class patientDetail extends StatefulWidget {
  const patientDetail({Key? key}) : super(key: key);

  @override
  _patientDetailState createState() => _patientDetailState();
}

// ignore: camel_case_types
class _patientDetailState extends State<patientDetail> {
  var sampleList = [];
  List events = [
    ["Patient's Profile", '/patientProfile'],
    ["Travel Residency", '/travelresidency'],
    ["Medical Checkup", '/checkup'],
    ["Treatment History", '/treatmenthistory'],
    ["Sample", '/sample'],
    ["Image", '/image'],
    ["Diagnosis", '/diagnosis'],
    ["Discrepancy", '/discrepancy']
  ];
  void initState() {
    var data;
    super.initState();
    _loadCounter();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Sample_Service.samplechecking(context);
      if (data != null) {
        setState(() {
          sampleList = data;
        });
        if (sampleList.contains('no content')) {
          setState(() {
            isButtonDisabled = true;
          });
        } else {
          setState(() {
            isButtonDisabled = false;
          });
        }
      }
    });
  }

  bool isButtonDisabled = false;
  String img = "";
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  String name = '';
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('patientIdentifier') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const switchbar()),
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
            title: Center(child: Text(name)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const switchbar()),
                )
              },
            ),
          ),
          backgroundColor: Colors.grey[300],
          body: Container(
              child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(events.length, (index) {
                    if (events[index][0] == "Patient's Profile") {
                      setState(() {
                        img = "assets/patientprofileicon.jpg";
                      });
                    } else if (events[index][0] == "Travel Residency") {
                      setState(() {
                        img = "assets/Travelicon.png";
                      });
                    } else if (events[index][0] == "Medical Checkup") {
                      setState(() {
                        img = "assets/checkupicon.png";
                      });
                    } else if (events[index][0] == "Treatment History") {
                      setState(() {
                        img = "assets/treatmenticon.png";
                      });
                    } else if (events[index][0] == "Sample") {
                      setState(() {
                        img = "assets/sampleicon.png";
                      });
                    } else if (events[index][0] == "Image") {
                      setState(() {
                        img = "assets/imageicon.png";
                      });
                    } else if (events[index][0] == "Diagnosis") {
                      setState(() {
                        img = "assets/diagnosticsicon.png";
                      });
                    } else {
                      setState(() {
                        img = "assets/discrepancyicon.png";
                      });
                    }
                    return Container(
                      margin:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        // border: Border.all(

                        //   color: Colors.grey,
                        //   width: 10,
                        // ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(5, 5),
                              color: Color(0xFF6985e8).withOpacity(0.8)),
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(-5, -5),
                              color: Color(0xFF6985e8).withOpacity(0.8))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Center(
                                child: Container(
                                  child: new Stack(
                                    children: [
                                      new Image.asset(
                                        img,
                                        width: 80,
                                        height: 80,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                events[index][0],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          onPressed: () {
                            if (isButtonDisabled) {
                              if (events[index][1] == '/diagnosis') {
                                return showAlertDialog(context);
                              } else {
                                Navigator.pushReplacementNamed(
                                  context,
                                  events[index][1],
                                );
                              }
                            }
                            if (events[index][0] == "Image") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const FloatingNavigation()),
                              );
                            } else {
                              Navigator.pushReplacementNamed(
                                context,
                                events[index][1],
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ))),
    );
    // child: Column(
    //   children: [
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //       padding:
    //           EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //       color: Color(0xFF077064),
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //       onPressed: () {
    //         Navigator.pushReplacementNamed(
    //           context,
    //           '/patientProfile',
    //         );
    //       },
    //       child: Text(
    //         "Patient's Profile",
    //         style: TextStyle(fontSize: 22, color: Colors.white),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {
    //           Navigator.pushReplacementNamed(
    //             context,
    //             '/travelresidency',
    //           );
    //         },
    //         child: Text("Travel residency",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //       padding:
    //           EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //       color: Color(0xFF077064),
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(30))),
    //       onPressed: () {
    //         Navigator.pushReplacementNamed(
    //           context,
    //           '/checkup',
    //         );
    //       },
    //       child: Text("Medical Checkup",
    //           style: TextStyle(fontSize: 22, color: Colors.white)),
    //     ),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {
    //           Navigator.pushReplacementNamed(
    //             context,
    //             '/treatmenthistory',
    //           );
    //         },
    //         child: Text("Treatement History",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {},
    //         child: Text("Sample",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {
    //           Navigator.pushReplacementNamed(
    //             context,
    //             '/image',
    //           );
    //         },
    //         child: Text("Image",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {},
    //         child: Text("Diagnostics",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //     SizedBox(
    //       height: 30,
    //     ),
    //     // ignore: deprecated_member_use
    //     RaisedButton(
    //         padding:
    //             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //         color: Color(0xFF077064),
    //         shape: RoundedRectangleBorder(
    //             borderRadius:
    //                 BorderRadius.all(Radius.circular(30))),
    //         onPressed: () {},
    //         child: Text("Discrepancy",
    //             style:
    //                 TextStyle(fontSize: 22, color: Colors.white))),
    //   ],
    // ))));
  }

  showAlertDialog(BuildContext context) {
    // Create button
    // ignore: deprecated_member_use
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERT"),
      content: Text("You don't have any sample id to enter this section !"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
