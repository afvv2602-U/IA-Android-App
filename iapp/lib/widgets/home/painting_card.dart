// painting_card.dart
import 'package:flutter/material.dart';
import 'package:iapp/db/models/painting.dart';

class PaintingCard extends StatelessWidget {
  final Painting painting;

  PaintingCard({required this.painting});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                painting.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  painting.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  painting.author,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                Text(
                  painting.style,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
