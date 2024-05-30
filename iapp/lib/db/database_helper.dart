import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final tableUser = 'user';
  static final tablePhotos = 'photos';
  static final tableProfile = 'profile'; // New table for profile

  static final columnId = '_id';
  static final columnName = 'nombre';
  static final columnSurname = 'apellido';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  static final columnPhotoId = '_photoId';
  static final columnUserId = 'userId';
  static final columnPhotoPath = 'photoPath';
  static final columnStyle = 'style';

  static final columnProfileId = 'id';
  static final columnUsername = 'username';
  static final columnDescription = 'description';
  static final columnProfileImagePath = 'profileImagePath';
  static final columnTags = 'tags'; // New column for tags

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUser (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnSurname TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tablePhotos (
            $columnPhotoId INTEGER PRIMARY KEY,
            $columnUserId INTEGER NOT NULL,
            $columnPhotoPath TEXT NOT NULL,
            $columnStyle TEXT,
            FOREIGN KEY ($columnUserId) REFERENCES $tableUser ($columnId)
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableProfile (
            $columnProfileId INTEGER PRIMARY KEY,
            $columnUsername TEXT,
            $columnDescription TEXT,
            $columnProfileImagePath TEXT,
            $columnTags TEXT
          )
          ''');
  }

  Future<int> getUserId(String email, String password) async {
    Database db = await instance.database;
    List<Map> result = await db.query(tableUser,
        columns: [columnId],
        where: '$columnEmail = ? AND $columnPassword = ?',
        whereArgs: [email, password]);

    if (result.isNotEmpty) {
      return result.first[columnId];
    } else {
      throw Exception('Usuario no encontrado');
    }
  }
}
