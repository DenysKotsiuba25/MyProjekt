import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsProvider with ChangeNotifier {
  final String _apiKey = 'YOUR_NEWSAPI_KEY';
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Future<void> fetchNews(String category) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _articles = (data['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
