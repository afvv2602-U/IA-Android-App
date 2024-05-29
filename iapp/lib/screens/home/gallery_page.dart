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
  String? _filterStyle;

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
        actions: [
          DropdownButton<String>(
            hint: Text("Filtrar por estilo"),
            value: _filterStyle,
            onChanged: (String? newValue) {
              setState(() {
                _filterStyle = newValue;
              });
              _loadUserPhotos();
            },
            items: <String>[
              'Barroco',
              'Cubismo',
              'Expresionismo',
              'Impresionismo',
              'Realismo',
              'Renacimiento',
              'Rococo',
              'Romanticismo'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
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
            if (_filterStyle != null) {
              photos = photos
                  .where((photo) => photo['style'] == _filterStyle)
                  .toList();
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                String photoPath = photos[index]['photoPath'];
                int photoId = photos[index]['_photoId'];
                String style = photos[index]['style'];

                return GestureDetector(
                  onTap: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailPage(
                          photoPath: photoPath,
                          style: style,
                          onDelete: () {
                            _deletePhoto(photoId);
                          },
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadUserPhotos();
                    }
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
