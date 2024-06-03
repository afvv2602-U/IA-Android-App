import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:iapp/db/models/museum.dart';
import 'package:iapp/db/database_helper.dart';

class MuseumQueries {
  Future<void> insertInitialMuseums(Database db, String tableMuseums) async {
    final String assetPath = 'assets/images/museos/';

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final List<String> imagePaths = manifestMap.keys
          .where(
              (String key) => key.startsWith(assetPath) && key.endsWith('.png'))
          .toList();

      Map<String, dynamic> descriptions = await _loadDescriptions();

      Map<String, List<String>> groupedImages = {};

      for (String path in imagePaths) {
        List<String> parts = path.replaceAll('\\', '/').split('/');
        if (parts.length >= 4) {
          String folderName = parts[3];
          groupedImages.putIfAbsent(folderName, () => []).add(path);
        }
      }

      for (String folderName in groupedImages.keys) {
        List<String> parts = folderName.split('-');
        String name = parts[0].replaceAll('_', ' ');
        String location = parts.sublist(1).join(', ');
        String description =
            descriptions[name]?['descripcion'] ?? 'Descripción no disponible';
        List<String> mainAttractions = List<String>.from(descriptions[name]
                ?['principales_atracciones'] ??
            ['No disponible']);
        List<String> images = groupedImages[folderName] ?? [];

        Map<String, dynamic> museum = {
          'name': name,
          'location': location,
          'imagePaths': json.encode(images),
          'description': description,
          'mainAttractions': json.encode(mainAttractions),
        };

        await db.insert(tableMuseums, museum);
        // print('Inserted museum: $museum'); // Verificación de la inserción
      }
    } catch (e) {
      print('Error al leer los assets: $e');
    }
  }

  Future<Map<String, dynamic>> _loadDescriptions() async {
    try {
      final String content = await rootBundle
          .loadString('assets/images/museos/descripciones.json');
      return json.decode(content);
    } catch (e) {
      print('Error al leer las descripciones: $e');
      return {};
    }
  }

  Future<List<Museum>> getMuseums() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result =
        await db.query(DatabaseHelper.tableMuseums);

    List<Museum> museums =
        result.isNotEmpty ? result.map((c) => Museum.fromMap(c)).toList() : [];

    return museums;
  }
}
