import 'package:flutter/material.dart';
import 'package:Aesthetica/screens/home/home_pages/home_page.dart';
import 'package:Aesthetica/screens/home/home_pages/profile_page.dart';
import 'package:Aesthetica/screens/login_register/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:Aesthetica/screens/home/home_pages/camera_page.dart';
import 'package:Aesthetica/screens/home/home_pages/gallery_page.dart';
import 'package:Aesthetica/screens/home/home_pages/search_page.dart';
import 'package:Aesthetica/widgets/home/navigation_bar.dart';
import 'package:Aesthetica/db/queries/profile_queries.dart';

class AppHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int userId;

  AppHomePage({required this.cameras, required this.userId});

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;
  final ValueNotifier<String?> _profileImageNotifier =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_myInterceptor);
    _loadProfileImage();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_myInterceptor);
    super.dispose();
  }

  bool _myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true; // Return true to stop the default back button behavior
  }

  List<Widget> get _pages {
    return [
      HomePage(userId: widget.userId),
      SearchPage(),
      ProfilePage(
        userId: widget.userId,
        onLogout: _handleLogout,
        profileImageNotifier: _profileImageNotifier,
      ),
      GalleryPage(userId: widget.userId),
      CameraPage(cameras: widget.cameras, userId: widget.userId),
    ];
  }

  Future<void> _loadProfileImage() async {
    String? profileImagePath = await ProfileQueries().getProfileImagePath();
    _profileImageNotifier.value = profileImagePath;
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
      MaterialPageRoute(
          builder: (context) => LoginPage(cameras: widget.cameras)),
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
        profileImageNotifier: _profileImageNotifier,
      ),
    );
  }
}
