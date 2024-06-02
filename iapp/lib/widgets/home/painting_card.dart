// painting_card.dart
import 'package:flutter/material.dart';
import 'package:iapp/db/models/painting.dart';

class PaintingCard extends StatelessWidget {
  final Painting painting;

  const PaintingCard({required this.painting});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(painting.imagePath),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              painting.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(painting.author),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(painting.style),
          ),
        ],
      ),
    );
  }
}
