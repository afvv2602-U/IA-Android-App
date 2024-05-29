import 'package:flutter/material.dart';
import 'dart:io';

class PhotoDetailPage extends StatelessWidget {
  final String photoPath;
  final VoidCallback onDelete;

  PhotoDetailPage({required this.photoPath, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalle de la Foto'),
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
