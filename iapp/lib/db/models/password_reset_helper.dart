import 'package:http/http.dart' as http;
import 'package:iapp/db/database_helper.dart';

class PasswordResetHelper {
  Future<bool> checkUserEmail(String email) async {
    return await DatabaseHelper.instance.checkUserEmail(email);
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
}
