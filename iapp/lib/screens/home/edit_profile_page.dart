import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String description;
  final String? profileImagePath;
  final String? backgroundImagePath;
  final void Function(String, String, String?, String?) onSave;

  EditProfilePage({
    required this.username,
    required this.description,
    this.profileImagePath,
    this.backgroundImagePath,
    required this.onSave,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _descriptionController;
  String? _profileImagePath;
  String? _backgroundImagePath;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _descriptionController = TextEditingController(text: widget.description);
    _profileImagePath = widget.profileImagePath;
    _backgroundImagePath = widget.backgroundImagePath;
  }

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImagePath = pickedFile.path;
        } else {
          _backgroundImagePath = pickedFile.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Icon(Icons.close),
                  ),
                  Text(
                    'Editar Perfil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onSave(
                        _usernameController.text,
                        _descriptionController.text,
                        _profileImagePath,
                        _backgroundImagePath,
                      );
                      Navigator.pop(context, true); // Cambiado a true
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery, false),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: _backgroundImagePath != null
                                      ? FileImage(File(_backgroundImagePath!))
                                      : AssetImage(
                                              'assets/images/profile/default_background.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery, true),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _profileImagePath != null
                                  ? FileImage(File(_profileImagePath!))
                                  : AssetImage(
                                          'assets/images/profile/default_profile.png')
                                      as ImageProvider,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre de usuario',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Inserta un nombre de usuario',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Breve Descripción',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Inserta una descripcion',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
