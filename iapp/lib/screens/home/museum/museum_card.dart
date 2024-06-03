import 'package:flutter/material.dart';
import 'package:iapp/db/models/museum.dart';
import 'package:animations/animations.dart';
import 'package:iapp/screens/home/museum/museum_detail_page.dart';

class MuseumCard extends StatelessWidget {
  final Museum museum;

  const MuseumCard({required this.museum});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(milliseconds: 500),
      openBuilder: (context, _) => MuseumDetailPage(museum: museum),
      closedElevation: 5,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      closedColor: Colors.white,
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Card(
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  // Image part
                  Container(
                    width: double.infinity,
                    height: 350, // Ajustado para mayor altura
                    child: Image.asset(
                      museum.imagePaths[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    width: double.infinity,
                    height: 350, // Ajustado para mayor altura
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Text part
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          museum.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          museum.location,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
