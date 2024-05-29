import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class PhotoQueries {
  Future<int> insertPhoto(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(DatabaseHelper.tablePhotos, row);
  }

  Future<List<Map<String, dynamic>>> getUserPhotos(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query(DatabaseHelper.tablePhotos,
        where: '${DatabaseHelper.columnUserId} = ?', whereArgs: [userId]);
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
