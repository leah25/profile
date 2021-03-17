
  import 'package:flutter/material.dart';
/// used on the titles of pages
Widget titleLogo(double scale) {
    return Container(
      child: Image.asset(
        'assets/images/COMPASeRevenue.png',
        scale: scale,
      ),
    );
  }


/// used to draw a line with word 'or' in it
  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }