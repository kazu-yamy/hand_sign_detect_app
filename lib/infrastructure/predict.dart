import 'package:http/http.dart' as http;

class ResortechRepository {
  static Future<http.Response> postImage(String imagePath, String ip) async {
    final url = Uri.parse('http://$ip/api/v1/predict');
    final request = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('image', imagePath);

    request.files.add(file);

    final response = await request.send();
    return await http.Response.fromStream(response);
  }
}
