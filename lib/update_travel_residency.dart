import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_lesionia_project/services/travel_service.dart';
import 'package:new_lesionia_project/widgets/CountryCity.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:location/location.dart' as Location;
import 'package:location/location.dart';
import 'package:new_lesionia_project/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class update_travel extends StatefulWidget {
  final int index;
  final String IDMVT;
  const update_travel(this.IDMVT, {Key? key, required this.index}) : super(key: key);

  @override
  _update_travelState createState() => _update_travelState();
}

enum SingingCharacter { yes, no, na }
enum SingingCharacter2 { yes, no, na }
enum UrbanRural { urban, rural, na }
enum City { defaultt, input, gps }

// ignore: camel_case_types
class _update_travelState extends State<update_travel>
    with SingleTickerProviderStateMixin {
  late String IDMVT=widget.IDMVT;
  //String IDMVT = ''; // Initialized as empty string
  late DateTime pickedDate;
  late AnimationController controller;
  late Animation animation;
  bool isLocation = false;
  var data;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    //IDMVT=widget.IDMVT;
    pickedDate = DateTime.now();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(
      // the controller can't have upperBound > 1
      parent: controller, // the controller you created
      curve: Curves.decelerate,
    );
    controller.forward();
    controller.addListener(() {});

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      //  await _loadCounter();

      //  data = await Travel_Service.gettravelbyid(context,idtravel);
      data=await Travel_Service.gettravelbyid(context);
      print("data recieved is :$data");
      if (data != null) {
        // You would need to define ReloadDATA() and CompareData() methods if they are critical
        // ReloadDATA();
        // CompareData();
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
      }
    });
  }

  // Placeholder methods for missing logic to allow code to compile if they were defined elsewhere
  void ReloadDATA() {
    // Implementation needed
  }
  void CompareData() {
    // Implementation needed
  }
  Future<Position> _determinePosition() async {
    // Implementation needed, e.g.:
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void GetAddressFromLatLong(Position position) async {
    // Implementation needed, e.g.:
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      locationMessage = '${place.locality}, ${place.country}';
    });
  }

  SingingCharacter? _character = SingingCharacter.na;
  SingingCharacter2? _character2 = SingingCharacter2.na;
  UrbanRural? _urbanRural = UrbanRural.na;
  City? _city = City.input;
  String name='';
  _loadCounter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      //   idtravel = (_prefs.getString('travel_id') ?? '');
      name= (_prefs.getString('idpatient'))!;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var country = TextEditingController();
  var state = TextEditingController();
  var city = TextEditingController();
  var travelid = TextEditingController();
  var type = TextEditingController();
  var duration = TextEditingController();
  var input = TextEditingController();
  var _typeAheadController = TextEditingController();
  String bitenotion = '';
  String residency = '';
  String urbanrural = '';
  String cityContext = 'Input';
  String locationMessage = '';
  // Removed initialization to an empty string here as it's fetched later
  String idpatient='';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
            title: (IDMVT.isEmpty)
                ? CircularProgressIndicator()
                : Center(child: Text("$idpatient")),
            backgroundColor: Color(0xFF077064),
          ),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, _) {
                    return Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: Column(children: [
                          SizedBox(
                            height: 60,
                          ),
                          Hero(
                            transitionOnUserGestures: true,
                            tag: widget.index,
                            child: Container(
                              height: 200,
                              width: 190,
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              'CITY ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<City>(
                                      value: City.defaultt,
                                      groupValue: _city,
                                      onChanged: (City? value) {
                                        setState(() {
                                          _city = value;
                                          cityContext = 'Default';
                                        });
                                      }),
                                  Text('Default',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: City.input,
                                      groupValue: _city,
                                      onChanged: (City? value) {
                                        setState(() {
                                          _city = value;
                                          cityContext = 'Input';
                                        });
                                      }),
                                  Text('Input',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: City.gps,
                                      groupValue: _city,
                                      onChanged: (City? value) {
                                        setState(() {
                                          _city = value;
                                          cityContext = 'gps';
                                        });
                                      }),
                                  Text('GPS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                          if (cityContext == "Default")
                            CountryStateCityPicker(
                              country: country,
                              state: state,
                              city: _typeAheadController,
                              textFieldInputBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 5.0),
                              ),
                            ),
                          if (cityContext == "Input")
                            TextFormField(
                              controller: input,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                    BorderSide(color: Colors.green)),
                                hintText: "Type a city",
                              ),
                            ),
                          if (cityContext == "gps")
                            Icon(
                              Icons.location_on,
                              size: 46.0,
                              color: Colors.blue,
                            ),

                          if (cityContext == "gps")
                            (isLocation)
                                ? CircularProgressIndicator()
                                : Text(locationMessage),
                          SizedBox(
                            height: 10,
                          ),
                          if (cityContext == "gps")
                            TextButton(
                              style:TextButton.styleFrom(
                                backgroundColor: Colors.blue[800],

                              ),
                              onPressed: () async {
                                setState(() {
                                  isLocation = true;
                                });
                                Position position = await _determinePosition();
                                if (position != null) {
                                  setState(() {
                                    GetAddressFromLatLong(position);
                                    isLocation = false;
                                  });
                                }
                              },
                              child: Text(
                                "Get Current Location",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              'Urban/Rural',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<UrbanRural>(
                                      value: UrbanRural.rural,
                                      groupValue: _urbanRural,
                                      onChanged: (UrbanRural? value) {
                                        setState(() {
                                          _urbanRural = value;
                                          urbanrural = 'Rural';
                                        });
                                      }),
                                  Text('Rural',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: UrbanRural.urban,
                                      groupValue: _urbanRural,
                                      onChanged: (UrbanRural? value) {
                                        setState(() {
                                          _urbanRural = value;
                                          urbanrural = 'Urban';
                                        });
                                      }),
                                  Text('Urban',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: UrbanRural.na,
                                      groupValue: _urbanRural,
                                      onChanged: (UrbanRural? value) {
                                        setState(() {
                                          _urbanRural = value;
                                          urbanrural = 'N/A';
                                        });
                                      }),
                                  Text('N/A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Visit Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: Center(
                              child: Text(
                                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            trailing: Icon(Icons.calendar_today),
                            onTap: () {
                              _pickDate(context);
                            },
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              'Bite Notion',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<SingingCharacter>(
                                      value: SingingCharacter.yes,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                          bitenotion = 'Yes';
                                        });
                                      }),
                                  Text('Yes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: SingingCharacter.no,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                          bitenotion = 'No';
                                        });
                                      }),
                                  Text('No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: SingingCharacter.na,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                          bitenotion = 'N/A';
                                        });
                                      }),
                                  Text('N/A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Residency',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<SingingCharacter2>(
                                      value: SingingCharacter2.yes,
                                      groupValue: _character2,
                                      onChanged: (SingingCharacter2? value) {
                                        setState(() {
                                          _character2 = value;
                                          residency = 'Yes';
                                        });
                                      }),
                                  Text(
                                    'Yes',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: SingingCharacter2.no,
                                      groupValue: _character2,
                                      onChanged: (SingingCharacter2? value) {
                                        setState(() {
                                          _character2 = value;
                                          residency = 'No';
                                        });
                                      }),
                                  Text('No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: SingingCharacter2.na,
                                      groupValue: _character2,
                                      onChanged: (SingingCharacter2? value) {
                                        setState(() {
                                          _character2 = value;
                                          residency = 'N/A';
                                        });
                                      }),
                                  Text('N/A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                          if (residency == 'No') ...[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Text(
                                'Duration',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: duration,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                    BorderSide(color: Colors.green)),
                                hintText: "Number of Weeks",
                              ),
                              inputFormatters: [
                                // ignore: deprecated_member_use
                                FilteringTextInputFormatter.allow((
                                    RegExp(r'^\d+\.?\d{0,2}'))),
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              // keyboardType: TextInputType.number,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                            ),
                          ],
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible:
                                false, // user must tap button!
                                builder: (
                                    BuildContext contextt,
                                    ) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Warning !'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              "Are you sure that you want to update this information ?"),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () async {
                                          // Fetch patient ID
                                          //String patientId = await AuthService.getPatientID();

                                          idpatient=idpatient;
                                          // *** FIX APPLIED HERE ***
                                          // Safely parse the duration text, defaulting to 0.0 if empty or invalid.
                                          double durationValue = double.tryParse(duration.text) ?? 0.0;

                                          await Travel_Service
                                              .updateTravelResidency(
                                            correctlyFormattedDateTime(
                                                pickedDate),
                                            durationValue, // Pass the safe double value
                                            residency,
                                            urbanrural,
                                            bitenotion,
                                            choosingCity(cityContext),
                                            context,
                                            widget.IDMVT,
                                            idpatient,
                                          );
                                          Navigator.pop(contextt);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.pop(contextt);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                              EdgeInsets.only(left: 20, right: 30, top: 30),
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
                                "UPDATE",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]));
                  }))),
    );
  }

  _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      locale: const Locale('fr', 'FR'),
      fieldHintText: 'dd/mm/yyyy',
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: DateTime(DateTime.now().year + 5),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  // *** REMOVED THE ERROR-PRONE stringtofloat METHOD ***
  // double stringtofloat(String num) {
  //   return double.parse(num);
  // }

  choosingCity(cityContext) {
    if (cityContext == 'Default') {
      return "${_typeAheadController.text}, ${state.text}, ${country.text}";
    } else if (cityContext == 'Input') {
      return input.text;
    } else if (cityContext == 'gps') {
      return locationMessage;
    }
    return '';
  }
}