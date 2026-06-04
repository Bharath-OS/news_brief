import 'package:flutter/material.dart';
import 'package:news_app/data/model/news_model.dart';
import 'package:news_app/features/bookmarks/view/bookmarks_screen.dart';
import 'package:news_app/features/home/view/home_screen.dart';
import 'package:news_app/features/news_details/view/news_details_screen.dart';
import 'package:news_app/features/search/view/search_screen.dart';
import 'package:news_app/features/splash/view/splash.dart';

class AppRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/search':
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case '/details':
        return MaterialPageRoute(
          builder: (context) =>
              NewsDetailsScreen(news: settings.arguments as Article),
        );
      case '/bookmark':
        return MaterialPageRoute(builder: (context) => BookmarksScreen());
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Couldn\'t find this route'))),
        );
    }
  }
}
