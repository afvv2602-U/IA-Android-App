import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> evaluateImage(File image) async {
    final url = 'https://aesthetica.myvnc.com:10900/predict';
    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(await http.MultipartFile.fromPath('file', image.path))
      ..headers['x-api-key'] = 'IRfzQeWjngxQWyfVP0xa-Ee4f5WPtJtZ_XeBLuu8-PE';

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al evaluar la imagen');
    }
  }
}
