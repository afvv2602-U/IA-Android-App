import 'package:flutter/material.dart';
import 'package:iapp/db/queries/photo_queries.dart';
import 'package:iapp/db/queries/profile_queries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iapp/config/colors.dart';
import 'dart:io';

class ProfilePageTest extends StatefulWidget {
  final int userId;
  final VoidCallback onLogout;

  ProfilePageTest({required this.userId, required this.onLogout});

  @override
  _ProfilePageTestState createState() => _ProfilePageTestState();
}

class _ProfilePageTestState extends State<ProfilePageTest> {
  String? _profileImagePath;
  String _username = '';
  String _description = '';
  List<String> _galleryPhotos = [];
  String? _backgroundImagePath;
  final ProfileQueries _profileQueries = ProfileQueries();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    var profile = await _profileQueries.getProfile();
    var photos = await PhotoQueries().getUserPhotos(widget.userId);
    setState(() {
      _profileImagePath = profile['profileImagePath'];
      _username = profile['username'] ?? 'Nombre de usuario';
      _description = profile['description'] ?? 'Descripción breve';
      _galleryPhotos =
          photos.map((photo) => photo['photoPath'] as String).toList();
      _backgroundImagePath = _galleryPhotos.isNotEmpty
          ? (_galleryPhotos..shuffle()).first
          : 'assets/images/profile/default_background.png';
    });
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
    await _profileQueries.insertOrUpdateProfile({
      'id': 1, // Make sure there is an id to identify the profile record
      'username': _username,
      'description': _description,
      'profileImagePath': _profileImagePath,
    });
    await _loadProfileData();
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todas las preferencias para cerrar sesión
    widget.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildProfileInfo(),
                    _buildGallery(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _backgroundImagePath != null
                  ? FileImage(File(_backgroundImagePath!))
                  : AssetImage('assets/images/profile/default_background.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: 16,
          child: GestureDetector(
            onTap: _updateProfileImage,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : AssetImage('assets/images/profile/default_profile.png')
                        as ImageProvider,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          right: 16,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Follow',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(Icons.mail, color: Colors.black, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _username,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${_username.toLowerCase().replaceAll(' ', '_')}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildStatColumn('Following', '204'),
                  _buildStatColumn('Followers', '1.2M'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            _description,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _galleryPhotos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(_galleryPhotos[index]),
              fit: BoxFit.cover,
            ),
          );
        },
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
                    hintText: '', // No hay etiquetas, ya no es necesario
                  ),
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
