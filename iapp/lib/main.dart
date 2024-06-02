import 'package:flutter/material.dart';
import 'package:iapp/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:iapp/config/strings.dart';
import 'package:iapp/widgets/normal_login/social_button_white.dart';
import 'package:iapp/widgets/normal_login/custom_main_button.dart';
import 'package:iapp/screens/login_register/login_page.dart';
import 'package:iapp/screens/home/home_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String email = prefs.getString('email') ?? '';
  String password = prefs.getString('password') ?? '';
  // Inicializa la base de datos
  await DatabaseHelper.instance.database;

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    email: email,
    password: password,
    cameras: cameras,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String email;
  final String password;
  final List<CameraDescription> cameras;

  const MyApp({
    required this.isLoggedIn,
    required this.email,
    required this.password,
    required this.cameras,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aesthetica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RalewayExtraLight',
      ),
      home: isLoggedIn
          ? FutureBuilder<int>(
              future: DatabaseHelper.instance.getUserId(email, password),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return AppHomePage(
                      cameras: cameras,
                      userId: snapshot.data!,
                    );
                  } else {
                    return LoginPage(cameras: cameras);
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          : StartPage(cameras: cameras),
    );
  }
}

class StartPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const StartPage({required this.cameras, Key? key}) : super(key: key);

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
                    MaterialPageRoute(
                      builder: (context) => LoginPage(cameras: cameras),
                    ),
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
