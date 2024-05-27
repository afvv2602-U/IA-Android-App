import 'package:flutter/material.dart';

// Import constants
import 'package:iapp/config/strings.dart';

// Import widgets
import 'package:iapp/widgets/normal_login/social_button_white.dart';
import 'package:iapp/widgets/normal_login/custom_main_button.dart';

// Import paginas
import 'package:iapp/screens/login_register/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aesthetica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RalewayExtraLight',
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background/bg_start.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 3),
              Text(
                AppStrings.appName,
                style: TextStyle(
                  fontFamily: 'EdensorTittle',
                  fontSize: 60,
                  color: Colors.black,
                ),
              ),
              Spacer(flex: 24),
              CustomButton(
                text: AppStrings.signIn,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialWhiteMediaButton(
                      iconPath: 'assets/icons/ic_google.png', onPressed: () {}),
                  SizedBox(width: 50),
                  SocialWhiteMediaButton(
                      iconPath: 'assets/icons/ic_apple.png', onPressed: () {}),
                  SizedBox(width: 50),
                  SocialWhiteMediaButton(
                      iconPath: 'assets/icons/ic_facebook.png',
                      onPressed: () {}),
                ],
              ),
              Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
