import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/travel_service.dart';
import 'package:new_lesionia_project/update_travel_residency.dart';
import 'package:new_lesionia_project/widgets/colors.dart';
import 'package:new_lesionia_project/widgets/style.dart';

// ignore: camel_case_types
class travelResidency extends StatefulWidget {
  //final String patientId;
  const travelResidency({Key? key}) : super(key: key);
  @override
  _travelResidencyState createState() => _travelResidencyState();
}

// ignore: camel_case_types
class _travelResidencyState extends State<travelResidency> {
 // late String  patientId;
  var dataliste = [];
  List cityy = [];
  var data;
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
   // patientId=widget.patientId;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Travel_Service.getalltravel(context);
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

  @override
  Widget build(BuildContext context) {
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
          title: Center(child: Text("Lesionia")),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.pushReplacementNamed(
                context,
                '/patientsDetail',
              )
            },
          ),
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
                              children: [],
                            )),
                      ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(children: [
                InkWell(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/addtravel'),
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
                              'Add Travel Residency',
                              style:Theme.of(context).textTheme.labelLarge!  // or labelMedium depending on your needs
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
                              "assets/addtravel.png",
                            ),
                          ),
                        ]))
                  ]),
                ),
              ]),
              SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      (dataliste.contains('no content'))
                          ? "Total Travel Residencies : 0"
                          : "Total Travel Residencies : " +
                              dataliste.length.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              if (dataliste.contains('no content')) ...[
                Container(
                  child: Center(
                    child: Text(
                      'There is no travel residency yet !',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
              if (!dataliste.contains('no content')) ...[
                SizedBox(
                  height: 200,
                  child: Scrollbar(
                    child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataliste.length,
                        itemBuilder: (context, index) {
                          var map = dataliste[index];
                          return Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                            child: hotDestinationCard(map['IDMVT'] ?? '',
                                map['city'] ?? '',
                                map['residency']?? '',
                                map['type'] ?? '',
                                context, index),
                          );
                        }),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget hotDestinationCard(String IDMVT, String cityName, String residency,
      String type, BuildContext context, index) {
    print(IDMVT);
    print('CityName: $cityName');
    print('Residency: $residency');
    print('Type: $type');
    cityy = cityName.split(',');

    return GestureDetector(
      onTap: () async => {
        AuthService.setTravelID(IDMVT),
        print(IDMVT),
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => update_travel(IDMVT,index: index))),

        // await EasyLoading.show(
        //   status: 'loading...',
        //   maskType: EasyLoadingMaskType.black,
        // ),
        // await EasyLoading.dismiss(),

        // Navigator.pushReplacementNamed(
        //   context,
        //   '/updatetravel',
        // )
      },
      child: Stack(children: [
        Hero(
          tag: index,
          child: Container(
            height: 200,
            width: 160,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage("assets/maps.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 200,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColor.primaryColor, Colors.transparent]),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 30,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

             //     PrimaryText(
             //  text:"idTravel is :$IDMVT "),
                if (cityy.length == 1)
                  PrimaryText(
                      color: AppColor.lightSecondary,
                      text: "City : " + cityy[0],
                      size: 12,
                      fontWeight: FontWeight.w800)
                else
                  PrimaryText(
                      color: AppColor.lightSecondary,
                      text: "City : " + cityy[2],
                      size: 12,
                      fontWeight: FontWeight.w800),
                PrimaryText(
                    color: AppColor.lightSecondary,
                    text: "Residency : $residency",
                    size: 15,
                    fontWeight: FontWeight.w800),
                SizedBox(height: 4),
                PrimaryText(
                    text: "Urban/Rural : $type",
                    color: AppColor.lightSecondary,
                    size: 12,
                    fontWeight: FontWeight.w800)
              ]),
        ),
      ]),
    );
  }
}
