import 'dart:convert';

import 'package:iapp/db/models/painting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';
import 'package:flutter/services.dart' show rootBundle;

class PaintingQueries {
  Future<void> insertInitialPaintings(
      Database db, String tablePaintings) async {
    final String assetPath = 'assets/images/bd/';

    try {
      // Cargar el contenido del manifiesto de los assets
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final List<String> imagePaths = manifestMap.keys
          .where(
              (String key) => key.startsWith(assetPath) && key.endsWith('.png'))
          .toList();

      for (String path in imagePaths) {
        // Normalizar los separadores de ruta para asegurarnos de que funcionan en todos los sistemas operativos
        List<String> parts = path.replaceAll('\\', '/').split('/');
        print('Parts: $parts');
        if (parts.length >= 6) {
          // Ajusta el índice según tu estructura de carpetas
          String style = parts[3]; // Cambiado a índice correcto
          String author = parts[4].replaceAll('_', ' ');
          String title = parts[5].replaceAll('_', ' ').replaceAll('.png', '');

          Map<String, dynamic> painting = {
            'title': title,
            'imagePath': path,
            'style': style,
            'author': author,
          };

          await db.insert(tablePaintings, painting);
          print('Inserted painting: $painting'); // Verificación de la inserción
        }
      }
    } catch (e) {
      print('Error al leer los assets: $e');
    }
  }

  Future<List<Painting>> getPaintings({String? style, String? author}) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result;

    if (style != null && author != null) {
      result = await db.query(
        DatabaseHelper.tablePaintings,
        where:
            '${DatabaseHelper.columnPaintingStyle} = ? AND ${DatabaseHelper.columnPaintingAuthor} = ?',
        whereArgs: [style, author],
      );
    } else if (style != null) {
      result = await db.query(
        DatabaseHelper.tablePaintings,
        where: '${DatabaseHelper.columnPaintingStyle} = ?',
        whereArgs: [style],
      );
    } else if (author != null) {
      result = await db.query(
        DatabaseHelper.tablePaintings,
        where: '${DatabaseHelper.columnPaintingAuthor} = ?',
        whereArgs: [author],
      );
    } else {
      result = await db.query(DatabaseHelper.tablePaintings);
    }

    List<Painting> paintings = result.isNotEmpty
        ? result.map((c) => Painting.fromMap(c)).toList()
        : [];

    print(
        'Retrieved paintings: $paintings'); // Agrega esto para verificar la recuperación de datos

    return paintings;
  }
}
