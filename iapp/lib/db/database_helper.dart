import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:iapp/db/queries/painting_queries.dart';
import 'package:iapp/db/queries/museum_queries.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final tableUser = 'user';
  static final tablePhotos = 'photos';
  static final tableProfile = 'profile';
  static final tablePaintings = 'paintings';
  static final tableMuseums = 'museums';

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
  static final columnBackgroundImagePath = 'backgroundImagePath';
  static final columnTags = 'tags';

  static final columnPaintingId = 'paintingId';
  static final columnPaintingTitle = 'title';
  static final columnPaintingImagePath = 'imagePath';
  static final columnPaintingStyle = 'style';
  static final columnPaintingAuthor = 'author';

  static final columnMuseumId = 'museumId';
  static final columnMuseumName = 'name';
  static final columnMuseumLocation = 'location';
  static final columnMuseumImagePaths = 'imagePaths';
  static final columnMuseumDescription = 'description';
  static final columnMuseumMainAttractions = 'mainAttractions';

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
            $columnBackgroundImagePath TEXT,
            $columnTags TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $tablePaintings (
            $columnPaintingId INTEGER PRIMARY KEY,
            $columnPaintingTitle TEXT NOT NULL,
            $columnPaintingImagePath TEXT NOT NULL,
            $columnPaintingStyle TEXT NOT NULL,
            $columnPaintingAuthor TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableMuseums (
            $columnMuseumId INTEGER PRIMARY KEY,
            $columnMuseumName TEXT NOT NULL,
            $columnMuseumLocation TEXT NOT NULL,
            $columnMuseumImagePaths TEXT NOT NULL,
            $columnMuseumDescription TEXT NOT NULL,
            $columnMuseumMainAttractions TEXT NOT NULL
          )
          ''');

    await PaintingQueries().insertInitialPaintings(db, tablePaintings);
    await MuseumQueries().insertInitialMuseums(db, tableMuseums);
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
