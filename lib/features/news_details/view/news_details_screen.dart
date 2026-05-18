import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bookmarks/bloc/bookmark_bloc.dart';

import '../../../data/model/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article news;

  const NewsDetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // TODO: Add BlocBuilder for managing bookmark state in details
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
              bool isBookmarked = false;
              if (state is BookmarkSuccess) {
                isBookmarked = state.bookmarkedArticles.any(
                  (a) => a.url == news.url && a.title == news.title,
                );
              }
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? AppColors.primary : Colors.white,
                ),
                onPressed: () {
                  if (!isBookmarked) {
                    context.read<BookmarkBloc>().add(AddToBookmark(news));
                  } else {
                    Article? articleToRemove;
                    if (state is BookmarkSuccess) {
                      try {
                        articleToRemove = state.bookmarkedArticles.firstWhere(
                          (a) => a.url == news.url && a.title == news.title,
                        );
                      } catch (e) {
                        articleToRemove = news;
                      }
                    } else {
                      articleToRemove = news;
                    }
                    context.read<BookmarkBloc>().add(
                      RemoveFromBookmark(articleToRemove),
                    );
                  }
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.urlToImage != null)
              Image.network(
                news.urlToImage!,
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 350,
                  color: AppColors.surfaceContainer,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.outline,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title ?? '', style: AppTextStyles.headlineLgMobile),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryContainer.withOpacity(
                          0.2,
                        ),
                        child: Text(
                          (news.source?.name ?? 'N').isNotEmpty
                              ? (news.source?.name ?? 'N')[0]
                              : 'N',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.source?.name ?? 'Unknown Source',
                            style: AppTextStyles.labelMd.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'By ${news.author ?? "Staff Writer"}',
                            style: AppTextStyles.labelSm,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    news.content ?? news.description ?? 'No content available.',
                    style: AppTextStyles.bodyLg,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Read More'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
