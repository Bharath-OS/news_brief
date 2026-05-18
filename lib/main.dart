import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/services/http_client.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/features/bookmarks/bloc/bookmark_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/splash/view/splash.dart';

void main() async {
  await dotenv.load(fileName: "secrets.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(AppClient(http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BookmarkBloc()),
          BlocProvider(
            create: (context) => HeadlinesBloc(
              context.read<NewsRepository>(),
              context.read<BookmarkBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
