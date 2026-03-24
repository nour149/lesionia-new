import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/treatment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreatementHistory extends StatefulWidget {
  const TreatementHistory({Key? key}) : super(key: key);

  @override
  State<TreatementHistory> createState() => _TreatementHistoryState();
}

class _TreatementHistoryState extends State<TreatementHistory> {
  var filteredList = [];
  var dataliste = [];
  String txt = '';
  String idpatient = "";
  Timer? _timer;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // 1. Start the loader
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );

      // 2. Load the patient ID first
      await _loadCounter();

      // 3. Fetch data
      try {
        var data = await Treatment_Service.getalltreatment(context);

        if (data != null) {
          setState(() {
            dataliste = data;
          });
        }
      } catch (e) {
        print("Error fetching treatments: $e");
      } finally {
        // 4. ALWAYS dismiss the loader when finished (success or failure)
        EasyLoading.dismiss();
      }
    });
  }
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patientIdentifier') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    (dataliste.contains('no content'))
        ? filteredList = dataliste
        : filteredList = dataliste
            .where((i) =>
                i['idtreatment'].toLowerCase().contains(txt.toLowerCase()))
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background3.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
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
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.black),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.7)),
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
                            ? "Total Treatments : 0"
                            : "Total Treatments : " +
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
                        context, '/addtreatment'),
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
                                'Add Treatment History',
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
                              width: 45,
                              child: Image.asset(
                                "assets/treatment.png",
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
                                'There is no treatment yet !',
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

                          return getCard(
                              user['idtreatment'],
                              user['treatment_TYPE'],
                              user['start_DATE'],
                              user['healing_DATE'],
                              user['prescribedfor'],
                              index,
                              context);
                        }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCard(treamtementid, treatmentType, date, healingDATE, predescribed,
      int index, BuildContext context) {
    const mintleaft = const Color(0xff042F39);
    const robineggblue = const Color(0xff075264);
    const electronblue = const Color(0xff0A758F);
    const exodusfruit = const Color(0xff0D98BA);
    // const lemon = const Color(0xff10BBE5);

    final List<Color> colors = <Color>[
      mintleaft,
      robineggblue,
      electronblue,
      exodusfruit,
    ];

    return Container(
      margin: EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 10),
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
            AuthService.setTreatmentID(treamtementid);
            Navigator.pushReplacementNamed(
              context,
              '/updatetreatment',
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 75,
                      height: 65,
                      child: Image.asset(
                        "assets/treatment.png",
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Treatment Type : ' + treatmentType,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Start Date : $date',
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Healing Date : $healingDATE',
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Predescribed For : ' + predescribed,
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
