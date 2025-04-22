import 'dart:convert';
import 'package:http/http.dart' as http;

class TrailerService {
  final String baseUrl;

  TrailerService(this.baseUrl);

  /// Fetches the trailer URL for the given film ID.
  Future<String?> fetchTrailer(String filmId) async {
    final uri = Uri.parse('$baseUrl/trailers/$filmId'); // Adjust this endpoint based on your API
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // Server returns the entire trailer object, so extract the trailerUrl property
      if (jsonResponse != null && jsonResponse.containsKey('trailer')) {
        return jsonResponse['trailer']['trailerUrl'];
      } else if (jsonResponse != null && jsonResponse.containsKey('trailerUrl')) {
        return jsonResponse['trailerUrl'];
      }
      return null; // Return null if no trailer found
    } else {
      throw Exception('Failed to load trailer: ${response.statusCode}');
    }
  }
}
