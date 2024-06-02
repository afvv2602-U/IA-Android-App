import 'dart:convert';

import 'package:iapp/db/models/painting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PaintingQueries {
  Future<void> saveToFileInChunks(String fileName, String content,
      {int chunkSize = 1024}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      final sink = file.openWrite();

      for (int i = 0; i < content.length; i += chunkSize) {
        int end =
            (i + chunkSize < content.length) ? i + chunkSize : content.length;
        sink.write(content.substring(i, end));
      }

      await sink.close();
      print('Saved $fileName to $filePath in chunks');
    } catch (e) {
      print('Error saving $fileName: $e');
    }
  }

  Future<void> insertInitialPaintings(
      Database db, String tablePaintings) async {
    print('Entro en insertInitialPaintings');
    final String assetPath = 'assets/images/bd/';

    try {
      // Cargar el contenido del manifiesto de los assets
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      if (manifestContent.isEmpty) {
        print('Manifest content is empty');
        return;
      }
      await saveToFileInChunks('manifestContent.txt', manifestContent);

      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      if (manifestMap.isEmpty) {
        print('Manifest map is empty');
        return;
      }
      await saveToFileInChunks('manifestMap.txt', json.encode(manifestMap));

      // Filtrar los archivos PNG en la carpeta assets/images/bd/
      final List<String> imagePaths = manifestMap.keys
          .where(
              (String key) => key.startsWith(assetPath) && key.endsWith('.png'))
          .toList();

      print('Procesando entidad: ${imagePaths.length}');
      print('Image Paths: $imagePaths'); // Verificar las rutas de las imágenes

      for (String path in imagePaths) {
        print('Procesando path: $path');
        // Normalizar los separadores de ruta para asegurarnos de que funcionan en todos los sistemas operativos
        List<String> parts = path.replaceAll('\\', '/').split('/');
        print('Parts: $parts');
        if (parts.length >= 5) {
          // Ajusta el índice según tu estructura de carpetas
          String style = parts[2]; // Cambiado a índice correcto
          String author = parts[3].replaceAll('_', ' ');
          String title = parts[4].replaceAll('_', ' ').replaceAll('.png', '');

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
