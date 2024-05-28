import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ProfilePage extends StatefulWidget {
  final int userId;
  final VoidCallback onLogout;

  ProfilePage({required this.userId, required this.onLogout});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todas las preferencias para cerrar sesión
    widget.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        automaticallyImplyLeading: false, // Disable back button in AppBar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _logout,
          child: Text('Cerrar sesión'),
        ),
      ),
    );
  }
}
