import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.white,
      child: Divider(
        color: Colors.black,
        thickness: 1,
      ),
    );
  }
}
