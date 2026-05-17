import 'package:news_app/core/services/http_client.dart';
import 'package:news_app/data/model/news_model.dart';

class NewsRepository {
  final AppClient _client;
  NewsRepository(this._client);

  Future<List<Article>> fetchNews(String category) async {
    try {
      final response = await _client.get(
        'top-headlines?country=us&category=$category',
      );
      final List<dynamic> newsList = response['articles'];
      final allNews = newsList.map((news) => Article.fromJson(news)).toList();
      return allNews;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
