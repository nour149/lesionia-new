import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function press;

  const MenuCard({
    required this.imageUrl,
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Column(
        children: <Widget>[
          Image.asset(
            imageUrl,
            width: 100,
            height: 135,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF25257E),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
