import 'package:flutter/material.dart';
import '../../config/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
