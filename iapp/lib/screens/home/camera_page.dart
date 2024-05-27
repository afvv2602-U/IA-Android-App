import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:iapp/screens/home/image_preview_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iapp/api/api_service.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraPage({required this.cameras});

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
  }

  void _initializeCamera() {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now()}.png';
      await image.saveTo(imagePath);

      await ApiService.evaluateImage(File(imagePath));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewPage(imagePath: imagePath),
        ),
      ).then((_) {
        _resetCamera();
      });
    } catch (e) {
      print(e);
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: double.infinity,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
          ),
        ],
      ),
    );
  }
}
