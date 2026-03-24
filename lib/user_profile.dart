import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_lesionia_project/services/myuser_service.dart';
import 'package:new_lesionia_project/widgets/navigation_drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Timer? _timer;
  String email = '';
  String name = '';
  String firstname = '';
  String lastname = '';
  String quality = '';

  // Necessary flag for conditional rendering
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCounter();

      // Fetch user data and email asynchronously
      var data = await Myuser_Service.getUser(context);
      var user = await Myuser_Service.getEmailbyUser(context);

      if (data != null && user != null) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });

        // --- DEBUG: Print raw data to console to verify content ---
        // You should check your console output for "Raw Interrogator Data:"
        // to ensure it contains firstname and lastname.
        print('Raw Interrogator Data: $data');
        print('Raw Email Data: $user');
        // -----------------------------------------------------------

        setState(() {
          // Use null-aware operator (?? '') in case the backend fields are missing
          firstname = data['first_NAME_INTERROGATOR'] ?? '';
          lastname = data['last_NAME_INTERROGATOR'] ?? '';
          quality = data['quality'] ?? '';
          //email = user['email'] ?? '';

          // Data is successfully loaded, stop loading indicator
          _isLoading = false;
        });
      } else {
        // Stop loading even if data fetching failed (to prevent infinite loading)
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('id') ?? '');
    });
  }

  // Helper function for multiline email display
  String _getEmailHint(String email) {
    return email.length < 28 ? 'Email : $email' : 'Email :\n$email';
  }

  @override
  Widget build(BuildContext context) {
    // FIX: Replace deprecated WillPopScope with PopScope
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFF077064),
        ),
        drawer:  NavigationDrawerWidget(), // Added const
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomPaint(
                child: Container(),
                painter: HeaderCurvedContainer(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/profile.png"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                // Conditional Rendering: Show Shimmer while data is loading
                child: _isLoading
                    ? const ShimmerProfile()
                    : Column(
                  children: [
                    textfield(hintText: 'First name : $firstname'),
                    const SizedBox(height: 10),
                    textfield(hintText: 'Last name : $lastname'),
                //    const SizedBox(height: 10),
                  //  textfield(hintText: _getEmailHint(email)),
                    const SizedBox(height: 10),
                    textfield(hintText: 'Quality : $quality'),
                    const SizedBox(height: 10),
                    textfield2(hintText: 'Change Password', context: context),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SHIMMER WIDGET (Loading Indicator) ---
class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(5, (index) => const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Material(
            elevation: 4,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(height: 50, width: double.infinity),
          ),
        )),
      ),
    );
  }
}


Widget textfield({required String hintText}) {
  return Material(
    elevation: 4,
    shadowColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      maxLines: null,
      enabled: false,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        fillColor: Colors.white30,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

Widget textfield2({required String hintText, required BuildContext context}) {
  return Material(
    elevation: 4,
    shadowColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/verifypw');
      },
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Colors.white30,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF077064);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}