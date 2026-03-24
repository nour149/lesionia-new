import 'package:flutter/material.dart';
//import 'package:lesionia_project/all_patients.dart';
import 'package:new_lesionia_project/patients.dart';
import 'package:new_lesionia_project/widgets/navigation_drawer_widget.dart';

// ignore: camel_case_types
class switchbar extends StatefulWidget {
  const switchbar({Key? key}) : super(key: key);

  @override
  _switchbarState createState() => _switchbarState();
}

// ignore: camel_case_types
class _switchbarState extends State<switchbar> {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');

        return true;
      },
      child: DefaultTabController(
          length: 2, //2 tabs will show at appbar
          child: Scaffold(
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
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF292639),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TabBar(
                                indicator: BoxDecoration(
                                    color: Color(0xF77064),
                                    borderRadius: BorderRadius.circular(8)),
                                tabs: [
                                  Tab(text: 'My patients'),
                               //   Tab(text: 'All Patients'),
                                ])),
                      ),
                      //710
                      SizedBox(
                        height: 650,
                        child: TabBarView(
                        children:
                        [
                           PatientPage(),
                           //all_patients(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
