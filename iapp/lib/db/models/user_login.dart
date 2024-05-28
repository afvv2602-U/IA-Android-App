import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class UserLogin {
  Future<bool> validateUser(String email, String password) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(DatabaseHelper.tableUser,
        columns: [DatabaseHelper.columnId],
        where:
            '${DatabaseHelper.columnEmail} = ? AND ${DatabaseHelper.columnPassword} = ?',
        whereArgs: [email, password]);

    return result.isNotEmpty;
  }
}
