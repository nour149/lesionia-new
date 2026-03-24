import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logoo.png',
            width: 250,
            height: 65,
          ),
        ],
      ),
    );
  }
}
