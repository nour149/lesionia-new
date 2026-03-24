import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:new_lesionia_project/services/sample_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  String idpatient = "";
  String txt = "";
  var filteredList = [];
  var sampleList = [];
  _loadPatientID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patientIdentifier') ?? '');
    });
  }

  @override
  void initState() {
    var data;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      data = await Sample_Service.getallsamplesbyid(context);
      if (!mounted) {
        return;
      }
      if (data != null) {
        setState(() {
          sampleList = data;
        });
      }
    });
    super.initState();
    _loadPatientID();
  }

  @override
  Widget build(BuildContext context) {
    (sampleList.contains('no content'))
        ? filteredList = sampleList
        : filteredList = sampleList
        .where(
            (i) => i['idsample'].toLowerCase().contains(txt.toLowerCase()))
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
                  image: AssetImage('assets/background2.jpg'),
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
                            ? "Total Samples : 0"
                            : "Total Samples : " +
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
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/addsample'),
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
                                'Add Sample',
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
                                "assets/sampleicon.png",
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
                          'There is no sample yet !',
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
                          user['idsample'],
                          user['type_OF_SAMPLE_SUPPORT_'],
                          user['sampling_METHOD'],
                          user['abudance_ON_THE_SMEAR'],
                          user['date_First_Apeard'],
                          index);
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

  Widget getCard(idsample, type, sampling, abudance, dateapeard, int index) {
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
          style: TextButton.styleFrom(
              padding: EdgeInsets.all(20),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9)),
          onPressed: () {
            AuthService.setSampleID(idsample);
            Navigator.pushReplacementNamed(
              context,
              '/updatesample',
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
                      height: 75,
                      child: Image.asset(
                        "assets/sampleicon.png",
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Text(
                    'Sample ID : $idsample',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Lesion first appearence : $dateapeard',
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sampling Method  :  $sampling',
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Abudance on the smear : $abudance',
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Type of sample  :  $type',
                style: TextStyle(color: Colors.black38),
              ),
            ],
          )),
    );
  }
}
