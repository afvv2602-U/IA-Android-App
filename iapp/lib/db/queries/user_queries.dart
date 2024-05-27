import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class UserQueries {
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query(DatabaseHelper.table);
  }

  Future<int?> queryRowCount() async {
    Database db = await DatabaseHelper.instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ${DatabaseHelper.table}'));
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = row['_id'];
    return await db
        .update(DatabaseHelper.table, row, where: '_id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db
        .delete(DatabaseHelper.table, where: '_id = ?', whereArgs: [id]);
  }
}
