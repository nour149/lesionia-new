import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/myuser_service.dart';
import 'package:new_lesionia_project/switchbar.dart';
import 'package:new_lesionia_project/widgets/HeaderWidget.dart';
import 'package:new_lesionia_project/widgets/navigation_drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  void initState() {
    var data;
    var user;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _loadCounter();
      data = await Myuser_Service.getUser(context);
      user = await Myuser_Service.getinstbyUser(context);
      if (!mounted) return;
      if (data != null && user != null) {
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          firstname = data['first_NAME_INTERROGATOR'];
          lastname = data['last_NAME_INTERROGATOR'];
      //    AuthService.setINST(user['IPT']);

        });
      }
    });
    // showToastMessage('Welcome ' +
    //     name +
    //     '. Take a look at your activites, standings and more');
  }

  final _storage = FlutterSecureStorage();
  String name = '';
  String firstname = '';
  String lastname = '';
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('id') ?? '');
    });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('No')),
              TextButton(
                  onPressed: () async {
                    await EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                 //   _storage.delete(key: 'token');
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                    await EasyLoading.dismiss();
                  },
                  child: Text("Yes"))
            ],
          ));
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 230;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Center(
              child: Text(
            "Lesionia",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
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
          backgroundColor: Color(0xFF077064),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: _headerHeight,
                  child: HeaderWidget(_headerHeight, true, firstname, lastname),
                ),

                // MyHeader(
                //   height: 250,
                //   imageUrl: 'assets/welcome.png',
                //   child: Column(
                //     children: <Widget>[
                //       SizedBox(
                //         height: 50,
                //       ),
                //       HeaderLogo(),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'Welcome ' + firstname + ' ' + lastname,
                //         style: TextStyle(
                //           fontSize: 28,
                //           color: Color(0xFF25257E),
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Spacer(),
                //       Icon(
                //         Icons.keyboard_arrow_down,
                //         color: Colors.white,
                //         size: 36,
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFDFCFF), Color(0xFFBCCBF3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // ignore: deprecated_member_use
                          ElevatedButton(
                            style:ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            shape: new RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            )
                                    ),

                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/profile');
                            },
                            child: new Column(
                              children: [
                                new Image.asset(
                                  "assets/profile.png",
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: Color(0xFF25257E),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          // ignore: deprecated_member_use
                          ElevatedButton(
                            style:ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            shape: new RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            )
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const switchbar()),
                              );
                            },
                            child: new Column(
                              children: [
                                new Image.asset(
                                  "assets/addpatient.png",
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    "Patients",
                                    style: TextStyle(
                                        color: Color(0xFF25257E),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          // ignore: deprecated_member_use
                          ElevatedButton(
                            style:ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.only(left: 35, right: 35)),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/news');
                            },
                            child: new Column(
                              children: [
                                new Image.asset(
                                  "assets/news.png",
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    "All News",
                                    style: TextStyle(
                                        color: Color(0xFF25257E),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          )
                        ],
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}