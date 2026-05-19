import 'package:news_app/core/services/http_client.dart';
import 'package:news_app/data/model/news_model.dart';

class NewsRepository {
  final AppClient _client;
  NewsRepository(this._client);

  static const String _topHeadlinesEndpoint = 'top-headlines';
  static const String _everythingEndpoint = 'everything';

  Future<List<Article>> fetchNews(String category) async {
    try {
      final response = await _client.get(
        '$_topHeadlinesEndpoint?country=us&category=$category',
      );
      final List<dynamic> newsList = response['articles'];
      final allNews = newsList.map((news) => Article.fromJson(news)).toList();
      return allNews;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    try {
      final response = await _client.get('$_everythingEndpoint?q=$query');
      final List<dynamic> result = response['articles'];
      final searchResult = result
          .map((article) => Article.fromJson(article))
          .toList();
      return searchResult;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
