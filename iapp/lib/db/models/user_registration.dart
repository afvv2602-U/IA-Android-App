import 'package:sqflite/sqflite.dart';
import 'package:aesthetica/db/database_helper.dart';

class UserRegistration {
  Future<int> registerUser(Map<String, dynamic> user) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(DatabaseHelper.tableUser, user);
  }
}
