import 'package:flutter/material.dart';
import 'dart:io';

class PhotoDetailPage extends StatelessWidget {
  final String photoPath;
  final String style;
  final VoidCallback onDelete;

  PhotoDetailPage({
    required this.photoPath,
    required this.style,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true); // Indicate successful navigation
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Estilo imagen: $style'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Image.file(
                File(photoPath),
                width: double.infinity, // Make image occupy full width
                fit: BoxFit.cover, // Maintain aspect ratio while filling space
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Información adicional sobre la foto...'),
            ),
            ElevatedButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context, true); // Indicate deletion to parent
              },
              child: Text('Eliminar Foto'),
            ),
          ],
        ),
      ),
    );
  }
}
