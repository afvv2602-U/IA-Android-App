import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AppHomePage extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String userId; // Cambiado a String

  const AppHomePage({required this.cameras, required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome, User ID: $userId'), // Mostrar el userId como cadena
      ),
    );
  }
}
