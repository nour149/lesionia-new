import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_lesionia_project/services/auth_service.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool isButtonActive = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    code = TextEditingController();
    code.addListener(() {
      if (code.text.length < 6) {
        setState(() {
          this.isButtonActive = false;
        });
      } else if (code.text.length == 6) {
        setState(() {
          this.isButtonActive = true;
        });
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      EasyLoading.addStatusCallback((status) {
        print('EasyLoading Status $status');
        if (status == EasyLoadingStatus.dismiss) {
          _timer?.cancel();
        }
      });
      code1 = await AuthService.getCode();
      setState(() {
        code2 = code1;
      });
    });
  }

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String aa = '';
  String bb = '';
  String code1 = '';
  String code2 = '';
  late TextEditingController code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     onTap: () => Navigator.pop(context),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 32,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/verification_code.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Enter Code',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "we have sent you an email with 6 digit verification code",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 6,
                        controller: code,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter you code';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: (isButtonActive)
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 32,
                                )
                              : Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.red,
                                  size: 32,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      ElevatedButton(
                        onPressed: isButtonActive
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  await EasyLoading.show(
                                    status: 'loading...',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  if (code.text == code2) {
                                    Navigator.pushReplacementNamed(
                                        context, '/newpw');
                                    await EasyLoading.dismiss();
                                  } else {
                                    await EasyLoading.dismiss();
                                    Fluttertoast.showToast(
                                      msg: "Wrong code !",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      timeInSecForIosWeb: 4,
                                      textColor: Colors.white,
                                      webBgColor: "#FF0000",
                                      webPosition: "center",
                                      fontSize: 16.0,
                                      webShowClose: true,
                                    );
                                  }
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (new Color(0xFF6DD6CA))),
                        child: Container(
                          alignment: Alignment.center,
                          height: 54,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _textFieldOTP({required bool first, last, required code}) {
    setState(() {
      if (aa == '') {
        aa = code.text;
      } else {
        aa = aa + code.text;
      }
    });

    return Container(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: code,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false && code == code) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false && code == code) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
