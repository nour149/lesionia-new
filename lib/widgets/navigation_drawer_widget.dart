import "package:flutter/material.dart";
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_lesionia_project/services/auth_service.dart';

final padding = EdgeInsets.symmetric(horizontal: 20);

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() =>
      new _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  static final _storage = FlutterSecureStorage();

  Widget build(BuildContext context) {
    final title = 'Lesionia';
    return Drawer(
      child: Material(
        color: Color(0xFF077064),
        child: ListView(
          children: <Widget>[
            Header(
              title: title,
              context: context,
            ),
            const SizedBox(height: 80),
            buildMenuItem(
              text: 'Home',
              icon: Icons.dashboard,
              onClicked: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                );
              },
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Stats',
              icon: Icons.bar_chart,
              onClicked: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/stats',
                );
              },
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.account_circle,
              onClicked: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/profile',
                );
              },
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Log Out',
              icon: Icons.logout_rounded,
              onClicked: () async => {
                await EasyLoading.show(
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                ),
                _storage.delete(key: 'token'),
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                ),
                await EasyLoading.dismiss(),
              },
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Header({
    required title,
    required context,
  }) =>
      InkWell(
        child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => {Navigator.pop(context)},
                ),
                Container(
                  height: 70,
                  width: 210,
                  child: Image.asset(
                    "assets/logoo.png",
                  ),
                ),
              ],
            )),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
