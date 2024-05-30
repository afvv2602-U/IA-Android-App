import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';

class ProfileQueries {
  final dbHelper = DatabaseHelper.instance;

  Future<void> insertOrUpdateProfile(Map<String, dynamic> profile) async {
    final db = await dbHelper.database;
    var profiles = await db.query('profile');

    if (profiles.isEmpty) {
      await db.insert('profile', profile);
    } else {
      await db.update('profile', profile, where: 'id = ?', whereArgs: [1]);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('profile', limit: 1);
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return {};
    }
  }
}
