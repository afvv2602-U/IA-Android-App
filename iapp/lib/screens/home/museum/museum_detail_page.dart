import 'package:flutter/material.dart';
import 'package:iapp/db/models/museum.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math'; // Importa dart:math para usar pi

class MuseumDetailPage extends StatefulWidget {
  final Museum museum;

  const MuseumDetailPage({required this.museum});

  @override
  _MuseumDetailPageState createState() => _MuseumDetailPageState();
}

class _MuseumDetailPageState extends State<MuseumDetailPage>
    with SingleTickerProviderStateMixin {
  bool _showBack = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_showBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme:
            IconThemeData(color: _showBack ? Colors.black : Colors.white),
      ),
      body: GestureDetector(
        onTap: _toggleCard,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = _animation.value * pi;
              final transform = Matrix4.rotationY(angle);
              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: _animation.value <= 0.5
                    ? _buildFrontPage()
                    : Transform(
                        transform: Matrix4.rotationY(pi),
                        alignment: Alignment.center,
                        child: _buildBackPage(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFrontPage() {
    return Container(
      key: ValueKey(true),
      color: Colors.black,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true, // Activar desplazamiento automático
              autoPlayInterval: Duration(seconds: 3), // Intervalo de 3 segundos
            ),
            items: widget.museum.imagePaths.map((path) {
              return Container(
                child: Image.asset(
                  path,
                  fit:
                      BoxFit.contain, // Ajustar para mostrar la imagen completa
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            }).toList(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.museum.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.museum.location,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackPage() {
    return Container(
      key: ValueKey(false),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.museum.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.museum.location,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.museum.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ...widget.museum.mainAttractions.map((attraction) => Text(
                  '- $attraction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
