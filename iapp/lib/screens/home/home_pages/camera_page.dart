import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:iapp/db/queries/photo_queries.dart';
import 'package:iapp/screens/home/gallery/image_preview_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iapp/api/api_service.dart';
import 'dart:io';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int userId;

  CameraPage({required this.cameras, required this.userId});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    BackButtonInterceptor.add(_myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_myInterceptor);
    _controller.dispose();
    super.dispose();
  }

  bool _myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Return true to stop the default back button behavior
    return true;
  }

  void _initializeCamera() {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now()}.png';
      await image.saveTo(imagePath);

      // Log the image path for debugging
      print('Image saved to $imagePath');

      // Evaluate the image and get the style
      String style = '';
      try {
        style = await ApiService.evaluateImage(File(imagePath));
      } catch (e) {
        print('Error evaluating image: $e');
      }

      // Insert photo into the database
      try {
        await PhotoQueries().insertPhoto({
          'userId': widget.userId,
          'photoPath': imagePath,
          'style': style,
        });
        print('Photo inserted into database');
      } catch (e) {
        print('Error inserting photo into database: $e');
      }

      if (mounted) {
        // Navigate to the preview page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImagePreviewPage(imagePath: imagePath, style: style),
          ),
        ).then((_) {
          _resetCamera();
        });
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void _resetCamera() {
    if (mounted) {
      setState(() {
        _initializeCamera();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: CameraPreview(_controller),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _takePicture,
                child: Icon(Icons.camera, color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
