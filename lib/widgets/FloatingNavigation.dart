import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:new_lesionia_project/SelectImage.dart';
import 'package:new_lesionia_project/image_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FloatingNavigation extends StatefulWidget {
  const FloatingNavigation({Key? key}) : super(key: key);

  @override
  State<FloatingNavigation> createState() => _FloatingNavigationState();
}

class _FloatingNavigationState extends State<FloatingNavigation> {
  ShapeBorder? bottomBarShape = BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  ));
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = EdgeInsets.zero;

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.rectangle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;
  String idpatient = "";
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  _loadPatientID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idpatient = (prefs.getString('patient_id') ?? '');
    });
  }

  List<Widget> pageList = <Widget>[SelectImage(), Image_History()];
  @override
  void initState() {
    _loadPatientID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Center(child: Text("$idpatient")),
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
      body: pageList[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) {
          setState(() => _selectedItemPosition = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Add photo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), label: 'Photo History'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
