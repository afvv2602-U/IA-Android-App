import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  CustomTextField({required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: 'RalewayExtraLight'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
