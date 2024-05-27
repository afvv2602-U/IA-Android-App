import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GalleryPage extends StatefulWidget {
  final String? imagePath;

  GalleryPage({this.imagePath});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
    if (widget.imagePath != null) {
      _saveImage(widget.imagePath!);
    }
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    List<String> imagePaths = [];
    for (FileSystemEntity file in files) {
      if (file.path.endsWith('.png')) {
        imagePaths.add(file.path);
      }
    }

    setState(() {
      _imagePaths = imagePaths;
    });
  }

  Future<void> _saveImage(String imagePath) async {
    setState(() {
      _imagePaths.add(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: _imagePaths.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.file(File(_imagePaths[index]));
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
