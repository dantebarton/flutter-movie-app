import 'dart:convert';

import 'package:ghibli_info_app/album.dart';
import 'package:http/http.dart' as http;

class FilmsAPI {
  static Future<List<Album>> fetchAlbum() async{
    const url = 'https://ghibliapi.vercel.app/films/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final films = json['films'] as List<dynamic>;
    final album = films.map((e) {
        return Album.fromMap(e);
    }).toList();
    return album;
  }
}