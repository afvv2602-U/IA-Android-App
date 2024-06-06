import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Aesthetica/db/queries/profile_queries.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ValueNotifier<String?> profileImageNotifier;

  CustomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.profileImageNotifier,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    widget.profileImageNotifier.addListener(_updateProfileImage);
  }

  @override
  void dispose() {
    widget.profileImageNotifier.removeListener(_updateProfileImage);
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    widget.profileImageNotifier.value =
        await ProfileQueries().getProfileImagePath();
  }

  void _updateProfileImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: widget.profileImageNotifier.value != null &&
                  widget.profileImageNotifier.value!.isNotEmpty
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:
                          FileImage(File(widget.profileImageNotifier.value!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Icon(Icons.person),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: '',
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
