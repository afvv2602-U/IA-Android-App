import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;
  final String style;

  ImagePreviewPage({required this.imagePath, required this.style});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estilo imagen: $style'),
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
