import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class UserLogin {
  Future<bool> validateUser(String email, String password) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(DatabaseHelper.table,
        columns: ['_id'],
        where: 'email = ? AND password = ?',
        whereArgs: [email, password]);

    return result.isNotEmpty;
  }
}
