import 'package:flutter/material.dart';
import '../../config/colors.dart';

class CustomLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomLoginButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // You can adjust this width as needed
      decoration: BoxDecoration(
        color: AppColors.baseNeutralOscura, // Color from your colors.dart
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow, // Shadow color from your colors.dart
            offset: Offset(3, 3), // shadow offset
            blurRadius: 2, // blur radius
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent, // Removing default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'RalewayExtraLight',
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
