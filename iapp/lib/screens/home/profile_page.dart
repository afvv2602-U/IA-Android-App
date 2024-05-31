import 'package:flutter/material.dart';
import 'package:iapp/db/queries/photo_queries.dart';
import 'package:iapp/db/queries/profile_queries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iapp/config/colors.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final int userId;
  final VoidCallback onLogout;

  ProfilePage({required this.userId, required this.onLogout});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _username = '';
  String _description = '';
  List<String> _tags = [];
  final ProfileQueries _profileQueries = ProfileQueries();

  final List<String> _predefinedTags = [
    'Barroco',
    'Renacimiento',
    'Cubismo',
    'Expresionismo',
    'Impresionismo',
    'Realismo',
    'Rococo',
    'Romanticismo'
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    var profile = await _profileQueries.getProfile();
    setState(() {
      _profileImagePath = profile['profileImagePath'];
      _username = profile['username'] ?? 'Nombre de usuario';
      _description = profile['description'] ?? 'Descripción breve';
      _tags = profile['tags']?.split(',') ?? [];
    });
    print('Profile data loaded');
    print('Username: $_username');
    print('Description: $_description');
    print('Profile Image Path: $_profileImagePath');
    print('Tags: $_tags');
  }

  Future<void> _updateProfileImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImagePath = pickedFile.path;
        });

        await _saveProfileData();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _saveProfileData() async {
    print('Saving profile data...');
    print('Username: $_username');
    print('Description: $_description');
    print('Profile Image Path: $_profileImagePath');
    print('Tags: $_tags');

    await _profileQueries.insertOrUpdateProfile({
      'id': 1, // Make sure there is an id to identify the profile record
      'username': _username,
      'description': _description,
      'profileImagePath': _profileImagePath,
      'tags': _tags.join(',')
    });
    await _loadProfileData(); // Ensure the latest data is loaded
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todas las preferencias para cerrar sesión
    widget.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.acentoSutil, AppColors.acentoPrincipal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Opciones',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar perfil'),
              onTap: () async {
                Navigator.of(context).pop();
                await _editProfileDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.of(context).pop();
                _logout();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildCollectionSection(),
            _buildTagsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.acentoSutil, AppColors.acentoPrincipal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _updateProfileImage,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.acentoSutil, AppColors.acentoPrincipal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : AssetImage('assets/images/profile/default_profile.png')
                        as ImageProvider,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            _description,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Colección',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: PhotoQueries().getUserPhotos(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar las fotos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay fotos disponibles'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String photoPath = snapshot.data![index]['photoPath'];
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(photoPath),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 150,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estilos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 60, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tags.length,
              itemBuilder: (context, index) {
                return _buildGradientChip(_tags[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientChip(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.acentoSutil, AppColors.acentoPrincipal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _tags.remove(tag);
                _saveProfileData();
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editProfileDialog(BuildContext context) async {
    final usernameController = TextEditingController();
    final descriptionController = TextEditingController();
    final tagsController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar perfil'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    hintText: _username,
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción breve',
                    hintText: _description,
                  ),
                ),
                TextField(
                  controller: tagsController,
                  decoration: InputDecoration(
                    labelText: 'Estilos (separados por comas)',
                    hintText: _tags.join(', '),
                  ),
                ),
                SizedBox(height: 10),
                Text('Estilos predefinidos'),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: _predefinedTags.map((tag) {
                    return ChoiceChip(
                      label: Text(tag),
                      selected: _tags.contains(tag),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _tags.add(tag);
                          } else {
                            _tags.remove(tag);
                          }
                          tagsController.text = _tags.join(', ');
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Guardar'),
              onPressed: () async {
                setState(() {
                  _username = usernameController.text.isNotEmpty
                      ? usernameController.text
                      : _username;
                  _description = descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : _description;
                  _tags = tagsController.text
                      .split(',')
                      .map((tag) => tag.trim())
                      .toList();
                });
                await _saveProfileData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
