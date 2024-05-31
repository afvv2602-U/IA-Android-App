import 'package:flutter/material.dart';
import 'package:aesthetica/config/strings.dart';
import 'package:aesthetica/screens/footer/contact.dart';
import 'package:aesthetica/screens/footer/suscriptions.dart';
import 'package:aesthetica/screens/footer/terms.dart';
import 'package:aesthetica/widgets/normal_login/social_button.dart';
import 'package:camera/camera.dart';

class FooterWithDivider extends StatelessWidget {
  final List<CameraDescription> cameras;

  const FooterWithDivider({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white,
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                AppStrings.appName,
                style: TextStyle(
                  fontFamily: 'EdensorTittle',
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton(
                    iconPath: 'assets/icons/ic_twitter.png',
                    url: 'https://twitter.com/',
                  ),
                  SizedBox(width: 20),
                  SocialMediaButton(
                    iconPath: 'assets/icons/ic_instagram.png',
                    url: 'https://www.instagram.com/',
                  ),
                  SizedBox(width: 20),
                  SocialMediaButton(
                    iconPath: 'assets/icons/ic_facebook.png',
                    url: 'https://www.facebook.com/',
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navegar a la página de Contactanos
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ContactPage(cameras: cameras)),
                      );
                    },
                    child: Text(
                      AppStrings.contactanos,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la página de Términos y Condiciones
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TermsConditionsPage(cameras: cameras)),
                      );
                    },
                    child: Text(
                      AppStrings.terms,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la página de Suscripciones
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SubscriptionsPage(cameras: cameras)),
                      );
                    },
                    child: Text(
                      AppStrings.suscripciones,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
