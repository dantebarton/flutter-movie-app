import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ghibli_info_app/album.dart';

class GhibliService {
  static const String _baseUrl = 'https://ghibliapi.vercel.app/films/';

  // Function to fetch films from the API
  static Future<List<Album>> fetchFilms() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> json = jsonDecode(body);
      return json.map((e) => Album.fromMap(e)).toList();
    } else {
      throw Exception("Failed to fetch films. Status code: ${response.statusCode}");
    }
  }
}
