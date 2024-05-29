import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> evaluateImage(File image) async {
    final url = 'https://aesthetica.myvnc.com:10900/predict';
    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(await http.MultipartFile.fromPath('file', image.path))
      ..headers['x-api-key'] = 'IRfzQeWjngxQWyfVP0xa-Ee4f5WPtJtZ_XeBLuu8-PE';

    try {
      final response = await request.send().timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        final responseData = json.decode(responseBody.body);
        final className = responseData['class_name'];
        print('Image evaluation result: $className');
        return className;
      } else {
        final responseBody = await http.Response.fromStream(response);
        print('Error evaluating image: ${responseBody.body}');
        throw Exception('Error al evaluar la imagen');
      }
    } catch (e) {
      print('Error evaluating image: $e');
      throw Exception('Error al evaluar la imagen');
    }
  }
}
