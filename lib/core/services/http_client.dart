import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/constats/app_constants.dart';

class AppClient {
  final http.Client _client;
  AppClient(this._client);

  final _headers = {"Authorization": "${dotenv.env['YOUR_API_KEY']}"};

  Future<dynamic> get(String endpoint) async {
    final appUrl = Uri.parse('${ApiConstants().baseUrl}$endpoint');
    try {
      final http.Response response = await _client.get(
        appUrl,
        headers: _headers,
      );
      final newsData = json.decode(response.body);
      if (response.statusCode == 200) {
        return newsData;
      } else if (response.statusCode == 400) {
        throw Exception('Bad request');
      } else if (response.statusCode == 404) {
        throw Exception('	The server can not find the requested resource.');
      } else {
        throw Exception(newsData['message']);
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
