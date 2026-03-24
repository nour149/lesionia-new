import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/myuser_service.dart';

class Changepw extends StatefulWidget {
  const Changepw({Key? key}) : super(key: key);

  @override
  _ChangepwState createState() => _ChangepwState();
}

class _ChangepwState extends State<Changepw> {
  Timer? _timer;
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  final newpw = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/profile');
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  '/profile',
                )
              },
            ),
          ),
          body: Container(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Center(
                          child: Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                new Container(
                  width: 300,
                  child: TextFormField(
                      obscureText: true,
                      controller: newpw,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)),
                          hintText: 'New password',
                          labelText: 'Enter your new password'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please enter your new password";
                        else {
                          return null;
                        }
                      }),
                ),
                SizedBox(height: 45),
                new Container(
                  width: 300,
                  child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)),
                          hintText: 'Repeat new password',
                          labelText: 'new password'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please repeat your new password";
                        else if (value != newpw.text) {
                          return 'Password Not Match';
                        } else {
                          return null;
                        }
                      }),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Myuser_Service.updatepw(newpw.text, context);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 120, right: 120, top: 30),
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
              ],
            ),
          ))),
    );
  }
}
