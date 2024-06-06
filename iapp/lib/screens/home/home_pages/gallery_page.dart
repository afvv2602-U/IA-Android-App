import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Aesthetica/config/colors.dart';
import 'package:Aesthetica/db/queries/photo_queries.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:Aesthetica/screens/home/gallery/photo_detail_page.dart';

class GalleryPage extends StatefulWidget {
  final int userId;

  GalleryPage({required this.userId});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Map<String, dynamic>>> _photos;
  String? _filterStyle;
  int _crossAxisCount = 3;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

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
      _photos = PhotoQueries().getUserPhotos(widget.userId).then((photos) {
        if (_filterStyle != null && _filterStyle!.isNotEmpty) {
          return photos
              .where((photo) => photo['style'] == _filterStyle)
              .toList();
        }
        return photos;
      });
    });
  }

  void _deletePhoto(int photoId) async {
    await PhotoQueries().deletePhoto(photoId);
    _loadUserPhotos();
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _currentScale = (_baseScale * details.scale).clamp(0.5, 4.0);
      if (_currentScale <= 0.75) {
        _crossAxisCount = 4;
      } else if (_currentScale <= 1.5) {
        _crossAxisCount = 3;
      } else if (_currentScale <= 2.5) {
        _crossAxisCount = 2;
      } else {
        _crossAxisCount = 1;
      }
    });
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  void _resetFilters() {
    setState(() {
      _filterStyle = null;
      _loadUserPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 40,
                left: 16,
                right: 16,
                bottom: 10), // Ajusta el padding para bajar la sección
            color: Colors.transparent, // Fondo transparente
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estilos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _resetFilters,
                ),
              ],
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _photos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print("Error al cargar las fotos: ${snapshot.error}");
                return Center(child: Text('Error al cargar las fotos'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print("No hay fotos disponibles");
                return Center(child: Text('No hay fotos disponibles'));
              } else {
                List<Map<String, dynamic>> photos = snapshot.data!;
                List<String> styles =
                    photos.map((p) => p['style'] as String).toSet().toList();
                return Flexible(
                  child: Column(
                    children: [
                      _buildTagsSection(styles, (String? newValue) {
                        setState(() {
                          _filterStyle = newValue;
                          _loadUserPhotos();
                        });
                      }),
                      Flexible(
                        child: GestureDetector(
                          onScaleStart: _handleScaleStart,
                          onScaleUpdate: _handleScaleUpdate,
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10), // Añadir padding lateral
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              String photoPath = photos[index]['photoPath'];
                              int photoId = photos[index]['_photoId'];
                              String style = photos[index]['style'];

                              return OpenContainer(
                                transitionType:
                                    ContainerTransitionType.fadeThrough,
                                transitionDuration: Duration(milliseconds: 500),
                                openBuilder: (context, _) => PhotoDetailPage(
                                  photoPath: photoPath,
                                  style: style,
                                  onDelete: () {
                                    _deletePhoto(photoId);
                                    Navigator.pop(context);
                                  },
                                ),
                                closedElevation: 5,
                                closedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                closedColor: Colors.white,
                                closedBuilder: (context, openContainer) {
                                  return GestureDetector(
                                    onTap: openContainer,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Hacer menos redondeados los bordes
                                      child: Image.file(
                                        File(photoPath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(List<String> tags, Function(String?) onSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.transparent, // Fondo transparente
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return _buildGradientChip(tags[index], onSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientChip(String tag, Function(String?) onSelected) {
    bool isSelected = (_filterStyle == tag);
    return GestureDetector(
      onTap: () {
        onSelected(isSelected ? null : tag);
      },
      child: Container(
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
            if (isSelected) ...[
              SizedBox(width: 8),
              Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
