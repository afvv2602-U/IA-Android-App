import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iapp/db/queries/profile_queries.dart'; // Asegúrate de tener este import correctamente.

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    // Simulating database call to get profile image path
    _profileImagePath = await ProfileQueries().getProfileImagePath();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: _profileImagePath != null && _profileImagePath!.isNotEmpty
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(File(_profileImagePath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
          label: 'Galería',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Cámara',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
