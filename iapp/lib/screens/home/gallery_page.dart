import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iapp/db/queries/photo_queries.dart';
import 'package:iapp/screens/home/photos/photo_detail_page.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class GalleryPage extends StatefulWidget {
  final int userId;

  GalleryPage({required this.userId});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Map<String, dynamic>>> _photos;

  @override
  void initState() {
    super.initState();
    _loadUserPhotos();
    BackButtonInterceptor.add(_myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_myInterceptor);
    super.dispose();
  }

  bool _myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true; // Return true to stop the default back button behavior
  }

  void _loadUserPhotos() {
    setState(() {
      _photos = PhotoQueries().getUserPhotos(widget.userId);
    });
  }

  void _deletePhoto(int photoId) async {
    await PhotoQueries().deletePhoto(photoId);
    _loadUserPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galería'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _photos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las fotos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay fotos disponibles'));
          } else {
            List<Map<String, dynamic>> photos = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                String photoPath = photos[index]['photoPath'];
                int photoId = photos[index]['id'];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailPage(
                          photoPath: photoPath,
                          onDelete: () {
                            _deletePhoto(photoId);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  child: Image.file(File(photoPath)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
