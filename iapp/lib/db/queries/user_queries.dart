import 'package:sqflite/sqflite.dart';
import 'package:iapp/db/database_helper.dart';
import 'package:http/http.dart' as http;

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

  // Password reset
  Future<bool> checkUserEmail(String email) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(DatabaseHelper.tableUser,
        columns: [DatabaseHelper.columnId],
        where: '${DatabaseHelper.columnEmail} = ?',
        whereArgs: [email]);

    return result.isNotEmpty;
  }

  Future<void> sendResetEmail(String email) async {
    final url = 'https://api.sendgrid.com/v3/mail/send';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_SENDGRID_API_KEY',
      },
      body: '''
      {
        "personalizations": [
          {
            "to": [{"email": "$email"}],
            "subject": "Restablecer tu contraseña"
          }
        ],
        "from": {"email": "no-reply@yourapp.com"},
        "content": [
          {
            "type": "text/plain",
            "value": "Por favor, haga clic en el siguiente enlace para restablecer su contraseña: https://yourapp.com/reset-password?email=$email"
          }
        ]
      }
      ''',
    );

    if (response.statusCode != 202) {
      throw Exception('Error al enviar el correo');
    }
  }

  Future<bool> validateUser(String email, String password) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(DatabaseHelper.tableUser,
        columns: [DatabaseHelper.columnId],
        where:
            '${DatabaseHelper.columnEmail} = ? AND ${DatabaseHelper.columnPassword} = ?',
        whereArgs: [email, password]);

    return result.isNotEmpty;
  }

  Future<int> registerUser(Map<String, dynamic> user) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(DatabaseHelper.tableUser, user);
  }
}
