import 'package:flutter/material.dart';
import 'package:iapp/config/strings.dart';

import 'package:iapp/widgets/normal_login/social_button.dart';

import 'package:iapp/screens/footer/terms.dart';
import 'package:iapp/screens/footer/contact.dart';
import 'package:iapp/screens/footer/suscriptions.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  url: 'https://twitter.com/'),
              SizedBox(width: 20),
              SocialMediaButton(
                  iconPath: 'assets/icons/ic_instagram.png',
                  url: 'https://www.instagram.com/'),
              SizedBox(width: 20),
              SocialMediaButton(
                  iconPath: 'assets/icons/ic_facebook.png',
                  url: 'https://www.facebook.com/'),
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
                    MaterialPageRoute(builder: (context) => ContactPage()),
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
                  // Navegar a la página de Contactanos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsConditionsPage()),
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
                  // Navegar a la página de Contactanos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionsPage()),
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
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
