import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/discrepancy_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Discrepancy extends StatefulWidget {
  const Discrepancy({Key? key}) : super(key: key);

  @override
  State<Discrepancy> createState() => _DiscrepancyState();
}

class _DiscrepancyState extends State<Discrepancy> {
  List filteredList = [];
  var dataliste = [];
  String txt = "";
  String idpatient = "";
  Timer? _timer;
  void initState() {
    var data;
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _loadCounter();
      data = await Discrepancy_Service.getalldiscrepancies(context);
      if (!mounted) return;
      if (data != null) {
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          dataliste = data;
        });
      }
    });
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patient_id') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    (dataliste.contains('no content'))
        ? filteredList = dataliste
        : filteredList = dataliste
            .where((i) =>
                i['iddiscrepancy'].toLowerCase().contains(txt.toLowerCase()))
            .toList();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/patientsDetail',
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.pushReplacementNamed(
                context,
                '/patientsDetail',
              )
            },
          ),
          title: Center(child: Text(idpatient)),
          backgroundColor: Color(0xFF077064),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Form(
                  child: Container(
                    child: SizedBox(
                      child: Column(children: [
                        new Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: Row(
                              children: [
                                Flexible(
                                    child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (text) {
                                    setState(() {
                                      txt = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                        Icon(Icons.search, color: Colors.black),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                ))
                              ],
                            )),
                      ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      (filteredList.contains('no content'))
                          ? "Total Discrepancies : 0"
                          : "Total Discrepancies : " +
                              filteredList.length.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                InkWell(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, '/adddiscrepancy'),
                  child: Row(children: [
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.0, 20.0),
                                  blurRadius: 30.0,
                                  color: Colors.black12)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.0)),
                        child: Row(children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            child: Text(
                              'Add Discrepancy',
                              style: Theme.of(context).textTheme.labelLarge!  // or labelMedium depending on your needs
                                  .apply(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFF077064),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(95.0),
                                    topLeft: Radius.circular(95.0),
                                    bottomRight: Radius.circular(200.0))),
                          ),
                          Container(
                            width: 50,
                            child: Image.asset(
                              "assets/discrepancyicon.png",
                            ),
                          ),
                        ]))
                  ]),
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              (filteredList.contains('no content'))
                  ? Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              'There is no discrepancy yet !',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(50),
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage("assets/nocontent.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  : new ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final user = filteredList[index];
                        return getCard(user['iddiscrepancy'], user['date_disc'],
                            user['datemed'], index);
                      }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCard(iddiscrepancy, dateDisc, datemed, int index) {
    DateTime date = DateTime.parse(dateDisc);
    var year = date.year;
    var month = date.month;
    var day = date.day;
    var hour = date.hour + 1;
    var minute = date.minute;
    var second = date.second;
    const mintleaft = const Color(0xff042F39);
    const robineggblue = const Color(0xff075264);
    const electronblue = const Color(0xff0A758F);
    const exodusfruit = const Color(0xff0D98BA);
    //const lemon = const Color(0xff737373);

    final List<Color> colors = <Color>[
      mintleaft,
      robineggblue,
      electronblue,
      exodusfruit,
    ];

    return Container(
      margin: EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: colors[index % colors.length],
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // ignore: deprecated_member_use
      child: TextButton(
        style:TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9)),
          onPressed: () {
            AuthService.setDiscrepancyID(iddiscrepancy);
            Navigator.pushReplacementNamed(
              context,
              '/updatediscrepancy',
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 65,
                      height: 65,
                      child: Image.asset(
                        "assets/discrepancyicon.png",
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Text(
                    'Discrepancy ID : $iddiscrepancy',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Date Desc : $year-$month-$day  $hour:$minute:$second',
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Medical Checkup Date : $datemed',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          )),
    );
  }
}
