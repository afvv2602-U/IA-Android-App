import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
  }

  static List<Widget> _pages(List<CameraDescription> cameras) => <Widget>[
        HomeScreen(),
        ProfilePage(),
        GalleryPage(),
        CameraPage(cameras: cameras),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameras.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: _pages(_cameras).elementAt(_selectedIndex),
            ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
