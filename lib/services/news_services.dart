import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";


class NewsService {
  static const String _baseUrl = 'https://gnews.io/api/v4';

  Future<List<dynamic>> fetchArticles({int count = 10}) async {
    final apiKey = dotenv.env['GNEWS_API_KEY'];
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?token=$apiKey&max=$count&lang=en')
    );

    if(response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<List<dynamic>> searchArticles(String query) async {
    final apiKey = dotenv.env['GNEWS_API_KEY'];
    final response = await http.get(
      Uri.parse('$_baseUrl/search?q=$query&token=$apiKey&lang=en')
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to search articles');
    }
  }
}