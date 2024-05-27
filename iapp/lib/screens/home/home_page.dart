import 'package:flutter/material.dart';

// Screens
import "package:iapp/screens/home/home_screen.dart";
import "package:iapp/screens/home/profile_page.dart";
import "package:iapp/screens/home/gallery_page.dart";
import "package:iapp/screens/home/camera_page.dart";

// Widgets
import 'package:iapp/widgets/home/navigation_bar.dart';

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    ProfilePage(),
    GalleryPage(),
    CameraPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
