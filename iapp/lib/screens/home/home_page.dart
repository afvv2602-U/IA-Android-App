import 'package:flutter/material.dart';
import 'package:iapp/main.dart';
import 'package:iapp/screens/login_register/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:iapp/screens/home/camera_page.dart';
import 'package:iapp/screens/home/gallery_page.dart';
import 'package:iapp/screens/home/profile_page.dart';
import 'package:iapp/widgets/home/navigation_bar.dart';

class AppHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int userId;

  AppHomePage({required this.cameras, required this.userId});

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_myInterceptor);
    super.dispose();
  }

  bool _myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Return true to stop the default back button behavior
    return true;
  }

  List<Widget> get _pages {
    return [
      HomeScreen(userId: widget.userId),
      ProfilePage(
        userId: widget.userId,
        onLogout: _handleLogout,
      ),
      GalleryPage(userId: widget.userId),
      CameraPage(cameras: widget.cameras, userId: widget.userId),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todas las preferencias para cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(cameras: cameras)),
    );
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

class HomeScreen extends StatelessWidget {
  final int userId;

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen for User $userId',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
