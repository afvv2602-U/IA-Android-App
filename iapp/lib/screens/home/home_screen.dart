import 'package:flutter/material.dart';

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
