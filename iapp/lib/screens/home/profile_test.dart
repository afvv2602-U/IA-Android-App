import 'package:flutter/material.dart';
import 'package:iapp/db/queries/photo_queries.dart';
import 'package:iapp/db/queries/profile_queries.dart';
import 'package:iapp/screens/home/edit_profile_page.dart';
import 'dart:io';

class ProfilePageTest extends StatefulWidget {
  final int userId;
  final VoidCallback onLogout;
  final ValueNotifier<String?> profileImageNotifier;

  ProfilePageTest({
    required this.userId,
    required this.onLogout,
    required this.profileImageNotifier,
  });

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
      widget.profileImageNotifier.value = _profileImagePath;
      _username = profile['username'] ?? 'Nombre de usuario';
      _description = profile['description'] ?? 'Descripción breve';
      _galleryPhotos =
          photos.map((photo) => photo['photoPath'] as String).toList();
      _backgroundImagePath = profile['backgroundImagePath'] ??
          'assets/images/profile/default_background.png';
    });
  }

  Future<void> _saveProfileData() async {
    await _profileQueries.insertOrUpdateProfile({
      'id': 1,
      'username': _username,
      'description': _description,
      'profileImagePath': _profileImagePath,
      'backgroundImagePath': _backgroundImagePath,
    });
    await _loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          height: 180,
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
            onTap: () {},
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
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  bool isUpdated = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          EditProfilePage(
                        username: _username,
                        description: _description,
                        profileImagePath: _profileImagePath,
                        backgroundImagePath: _backgroundImagePath,
                        onSave: (updatedUsername,
                            updatedDescription,
                            updatedProfileImagePath,
                            updatedBackgroundImagePath) {
                          setState(() {
                            _username = updatedUsername;
                            _description = updatedDescription;
                            _profileImagePath = updatedProfileImagePath;
                            _backgroundImagePath = updatedBackgroundImagePath;
                            widget.profileImageNotifier.value =
                                _profileImagePath;
                          });
                          _saveProfileData();
                        },
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                  if (isUpdated) {
                    _loadProfileData();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(Icons.edit, color: Colors.black, size: 20),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 60),
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
                  SizedBox(height: 10),
                  Text(
                    _description,
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
}
