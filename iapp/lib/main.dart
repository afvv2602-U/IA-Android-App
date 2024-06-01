import 'package:flutter/material.dart';
import 'package:aesthetica/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:aesthetica/config/strings.dart';
import 'package:aesthetica/widgets/normal_login/social_button_white.dart';
import 'package:aesthetica/widgets/normal_login/custom_main_button.dart';
import 'package:aesthetica/screens/login_register/login_page.dart';
import 'package:aesthetica/screens/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String email = prefs.getString('email') ?? '';
  String password = prefs.getString('password') ?? '';

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
                      userId: snapshot.data!.toString(), // Convertir int a String
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

  Future<User?> signInWithGoogle(BuildContext context, List<CameraDescription> cameras) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // El usuario canceló el inicio de sesión
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

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
                    iconPath: 'assets/icons/ic_google.png',
                    onPressed: () async {
                      User? user = await signInWithGoogle(context, cameras);
                      if (user != null) {
                        print("Inicio de sesión exitoso: ${user.displayName}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppHomePage(
                              cameras: cameras,
                              userId: user.uid,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 50),
                  SocialWhiteMediaButton(
                      iconPath: 'assets/icons/ic_apple.png', onPressed: () {}),
                  SizedBox(width: 50),
                  SocialWhiteMediaButton(
                      iconPath: 'assets/icons/ic_facebook.png', onPressed: () {}),
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
