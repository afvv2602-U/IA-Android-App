import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class UserQueries {
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query(DatabaseHelper.tableUser);
  }

  Future<int?> queryRowCount() async {
    Database db = await DatabaseHelper.instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ${DatabaseHelper.tableUser}'));
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = row[DatabaseHelper.columnId];
    return await db.update(DatabaseHelper.tableUser, row,
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(DatabaseHelper.tableUser,
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [id]);
  }
}
