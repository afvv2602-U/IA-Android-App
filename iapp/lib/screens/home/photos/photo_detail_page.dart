import 'package:flutter/material.dart';
import 'dart:io';

class PhotoDetailPage extends StatelessWidget {
  final String photoPath;
  final VoidCallback onDelete;

  PhotoDetailPage({required this.photoPath, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Foto'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(photoPath)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Información adicional sobre la foto...'),
          ),
          ElevatedButton(
            onPressed: onDelete,
            child: Text('Eliminar Foto'),
          ),
        ],
      ),
    );
  }
}
