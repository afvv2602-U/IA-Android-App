import 'package:flutter/material.dart';
import 'package:iapp/config/strings.dart';
import 'package:iapp/screens/login_register/login_page.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(
                fontFamily: 'EdensorTittle',
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                AppStrings.access,
                style: TextStyle(
                  fontFamily: 'TheMunday',
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}