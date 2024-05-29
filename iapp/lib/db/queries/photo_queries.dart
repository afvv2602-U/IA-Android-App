import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class PhotoQueries {
  Future<int> insertPhoto(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(DatabaseHelper.tablePhotos, row);
  }

  Future<List<Map<String, dynamic>>> getUserPhotos(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query(
        DatabaseHelper.tablePhotos,
        where: '${DatabaseHelper.columnUserId} = ?',
        whereArgs: [userId]);

    // Ensure no null values in the results
    return result.map((photo) {
      return {
        'id': photo[DatabaseHelper.columnPhotoId] as int,
        'photoPath': photo[DatabaseHelper.columnPhotoPath] as String,
      };
    }).toList();
  }

  Future<int> deletePhoto(int photoId) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(DatabaseHelper.tablePhotos,
        where: '${DatabaseHelper.columnPhotoId} = ?', whereArgs: [photoId]);
  }

  Future<int> updatePhoto(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = row[DatabaseHelper.columnPhotoId];
    return await db.update(DatabaseHelper.tablePhotos, row,
        where: '${DatabaseHelper.columnPhotoId} = ?', whereArgs: [id]);
  }
}
