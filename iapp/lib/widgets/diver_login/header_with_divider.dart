import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:aesthetica/config/strings.dart';
import 'package:aesthetica/screens/login_register/login_page.dart';

class HeaderWithDivider extends StatelessWidget {
  final List<CameraDescription> cameras;

  const HeaderWithDivider({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      MaterialPageRoute(
                          builder: (context) => LoginPage(cameras: cameras)),
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
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white,
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
