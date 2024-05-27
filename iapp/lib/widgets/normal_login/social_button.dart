import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final String url;

  SocialMediaButton({required this.iconPath, required this.url});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(this.url))) {
    throw Exception('Could not launch $this.url');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(iconPath),
      iconSize: 51,
      onPressed: _launchUrl,
    );
  }

}