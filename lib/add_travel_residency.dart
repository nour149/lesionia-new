import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_lesionia_project/services/travel_service.dart';
import 'package:new_lesionia_project/widgets/CountryCity.dart';
import 'package:new_lesionia_project/widgets/convertDate.dart';
import 'package:location/location.dart' as Location;
import 'package:location/location.dart';
import 'package:flutter/services.dart';
// ignore: camel_case_types
class add_travel_residency extends StatefulWidget {
  const add_travel_residency({Key? key}) : super(key: key);

  @override
  _add_travel_residencyState createState() => _add_travel_residencyState();
}

enum SingingCharacter { yes, no, na }
enum SingingCharacter2 { yes, no, na }
enum UrbanRural { urban, rural, na }
enum City { defaultt, input, gps }

// ignore: camel_case_types
class _add_travel_residencyState extends State<add_travel_residency> {
  late DateTime pickedDate;
  // late Position osition;
  List<String> cities = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   position = await _determinePosition();
    // });
    // country.text = "Tunisia";
    // _determinePosition();
    super.initState();
    pickedDate = DateTime.now();
  }

  // ignore: unused_field
  bool isLocation = false;
  String _selectedCity = '';
  var travelid = TextEditingController();
  var state = TextEditingController();
  var country = TextEditingController();
  var city = TextEditingController();
  var type = TextEditingController();
  var duration = TextEditingController();
  var input = TextEditingController();
  String bitenotion = 'N/A';
  String residency = 'N/A';
  String urbanrural = 'N/A';
  String cityContext = "default";
  SingingCharacter? _character = SingingCharacter.na;
  SingingCharacter2? _character2 = SingingCharacter2.na;
  UrbanRural? _urbanRural = UrbanRural.na;
  City? _city = City.defaultt;
  String locationMessage = "";
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/travelresidency',
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
            backgroundColor: Color(0xFF077064),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.pushReplacementNamed(
                  context,
                  '/travelresidency',
                )
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: [
                  Container(
                    child: Text(
                      'CITY ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                                  cityContext = 'default';
                                });
                              }),
                          Text('Default',
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                                  cityContext = 'input';
                                });
                              }),
                          Text('Input',
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  if (cityContext == "default")
                    CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      textFieldInputBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 5.0),
                      ),
                    ),
                  if (cityContext == "input")
                    TextFormField(
                      controller: input,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: "Type a city",
                      ),
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
                      onPressed: () async {
                        setState(() {
                          isLocation = true;
                        });
                        Position position = await _determinePosition();
                        if (position != null) {
                          setState(() {
                            GetAddressFromLatLong(position);
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[800], // ✅ Background color
                        foregroundColor: Colors.white,     // ✅ Text color
                      ),
                      child: Text("Get Current Location"),
                    ),
                  // TypeAheadFormField(
                  //   textFieldConfiguration: TextFieldConfiguration(
                  //     controller: this._typeAheadController,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //           borderSide: BorderSide(color: Colors.red)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           borderSide: BorderSide(color: Colors.green)),
                  //       hintText: 'Enter City',
                  //     ),
                  //   ),
                  //   suggestionsCallback: (pattern) {
                  //     return getSuggestions(pattern);
                  //   },
                  //   itemBuilder: (context, suggestion) {
                  //     return ListTile(
                  //       title: Text("$suggestion"),
                  //     );
                  //   },
                  //   transitionBuilder: (context, suggestionsBox, controller) {
                  //     return suggestionsBox;
                  //   },
                  //   onSuggestionSelected: (suggestion) {
                  //     setState(() {
                  //       this._typeAheadController.text = suggestion.toString();
                  //       print(_typeAheadController.text);
                  //     });
                  //   },
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please select a city';
                  //     }
                  //   },
                  //   onSaved: (value) {
                  //     setState(() {
                  //       this._selectedCity = value!;
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      'Urban/Rural',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold))
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
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  if (residency == "No") ...[
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
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: "Number of Weeks",
                      ),
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await Travel_Service.saveTravelResidency(
                            correctlyFormattedDateTime(pickedDate),
                            stringtofloat(duration.text),
                            residency,
                            urbanrural,
                            bitenotion,
                            choosingCity(cityContext),
                            context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 30, top: 30),
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
                ])),
          ))),
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

  double stringtofloat(String num) {
    if (num.isEmpty) {
      return double.parse("0");
    } else {
      return double.parse(num);
    }
  }

  choosingCity(cityContext) {
    if (cityContext == "default") {
      return country.text + ", " + state.text + ", " + city.text;
    } else if (cityContext == "input") {
      return input.text;
    } else {
      return locationMessage;
    }
  }

  Future _determinePosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();

    //   if (permission == LocationPermission.deniedForever) {
    //     // Permissions are denied forever, handle appropriately.
    //     return Future.error(
    //         'Location permissions are permanently denied, we cannot request permissions.');
    //   }

    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     return Future.error('Location permissions are denied');
    //   }
    // }
    // // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   return Future.error('Location services are disabled.');
    // }

    // // When we reach here, permissions are granted and we can
    // // continue accessing the position of the device.

    Location.Location location = new Location.Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
// LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      locationMessage =
          "${place.country}, ${place.administrativeArea}, ${place.subAdministrativeArea}";
    });
    setState(() {
      isLocation = false;
    });
  }
}
