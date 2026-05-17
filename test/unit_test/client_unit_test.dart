import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:news_app/core/services/http_client.dart';

void main() async {
  await dotenv.load(fileName: "secrets.env");
  late AppClient appClient;
  setUp(() {
    appClient = AppClient(Client());
  });
  test(
    'When called the get() of the client, should return a response',
    () async {
      final result = await appClient.get('top-headlines?country=us');
      debugPrint(result.toString());
      expect(result['status'], equals('ok'));
    },
  );
}
