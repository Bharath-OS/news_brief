import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/dummy_data.dart';
import 'package:news_app/core/widgets/news_card.dart';
import 'package:news_app/data/model/news_model.dart';

import '../bloc/bookmark_bloc.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement BlocBuilder to fetch saved bookmarks
    final List<Article> bookmarkedNews = context
        .watch<BookmarkBloc>()
        .bookmarkedArticles;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookmarks')),
      body: BlocConsumer<BookmarkBloc, BookmarkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (bookmarkedNews.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: AppColors.outlineVariant,
                    ),
                    const SizedBox(height: 16),
                    Text('No bookmarks yet', style: AppTextStyles.headlineMd),
                    const SizedBox(height: 8),
                    Text(
                      'Articles you save will appear here for easy reading later.',
                      style: AppTextStyles.bodyMd,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedNews.length,
              itemBuilder: (context, index) {
                return NewsCard(news: bookmarkedNews[index]);
              },
            );
          }
        },
      ),
    );
  }
}
