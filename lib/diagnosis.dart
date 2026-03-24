import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/diagnosis_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diagnosis extends StatefulWidget {
  const Diagnosis({Key? key}) : super(key: key);

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  String idpatient = "";
  String? value;
  String txt = "";
  var idsample = [];
  var datalist = [];
  var dataliste = [];

  _loadPatientID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patient_id') ?? '');
    });
  }

  @override
  void initState() {
    String patientId ="";
    var data;
    super.initState();
    _loadPatientID();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Sample_Service.getSampleID(context);
      if (data != null) {
        setState(() {
          idsample = data;
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
            {
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
              SizedBox(
                height: 50,
              ),
              Row(children: [
                InkWell(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/adddiagnosis'),
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
                              'Add Diagnosis',
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
                              "assets/diagnosticsicon.png",
                            ),
                          ),
                        ]))
                  ]),
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        hint: Center(
                            child: Text(
                              "Select id sample to fetch",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        value: value,
                        iconSize: 36,
                        isExpanded: true,
                        items: idsample.map((item) {
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
                        onChanged: (value) async {
                          setState(() {
                            this.value = value!;
                          });
                          datalist = await DiagnosisService.getAllDiagnosis(context, value!);
                          if (!datalist.contains('no content')) {
                            setState(() {
                              dataliste = datalist;
                            });
                          } else if (datalist.contains('no content')) {
                            setState(() {
                              Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'There is no diagnosis folder with this id',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
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
                                        image:
                                        AssetImage("assets/nocontent.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                          }
                        }),
                  ),
                ),
              ),
              (datalist.contains('no content'))
                  ? Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'There is no diagnosis folder with this id',
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
                  itemCount: datalist.length,
                  itemBuilder: (context, index) {
                    final user = datalist[index];

                    return getCard(
                        user['iddiagnosis'],
                        user['laboratoryname'],
                        user['test'],
                        user['result'],
                        user['diagnosisdate'],
                        index);
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

  Widget getCard(iddiagnosis, laboratoryname, test, result, diagnosisdate, int index) {
    const mintleaft = const Color(0xff042F39);
    const robineggblue = const Color(0xff075264);
    const electronblue = const Color(0xff0A758F);
    const exodusfruit = const Color(0xff0D98BA);

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
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            backgroundColor: Color(0xFFF5F6F9),
            foregroundColor: Colors.black, // Changed from primary to foregroundColor
          ),
          onPressed: () {
            AuthService.setDiagnosisID(iddiagnosis);
            Navigator.pushReplacementNamed(
              context,
              '/updatediagnosis',
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        "assets/diagnosticsicon.png",
                      )),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Text(
                    'Diagnosis ID : $iddiagnosis',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 10),
              Text(
                'Diagnosis Date : $diagnosisdate',
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                'Test : $test',
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 10),
              Text(
                'Result : $result',
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(height: 10),
              Text(
                'Laboratory :  $laboratoryname',
                style: TextStyle(color: Colors.black38),
              ),
            ],
          )),
    );
  }

}