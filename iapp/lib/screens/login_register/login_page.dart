import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class LoginPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const LoginPage({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
