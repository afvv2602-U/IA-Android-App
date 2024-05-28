import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;

  ImagePreviewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista previa de la imagen'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.file(File(imagePath)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
