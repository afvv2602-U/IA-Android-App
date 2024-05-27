import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;

  RoundButton({required this.onPressed, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Image.asset(assetName),
        iconSize: 120.0,
        onPressed: onPressed,
      ),
    );
  }
}
