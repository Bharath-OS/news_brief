import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/features/bookmarks/bloc/bookmark_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/news_details/view/news_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/news_model.dart';

class NewsCard extends StatelessWidget {
  final Article news;
  final VoidCallback? onPressed;
  const NewsCard({super.key, required this.news, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onPressed ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailsScreen(news: news),
              ),
            );
          },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      height: 180,
                      width: double.infinity,
                      color: AppColors.surfaceContainer,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.outline,
                      ),
                    ),
                  ),
                ),
              if (news.urlToImage != null) const SizedBox(height: 12),
              Text(
                news.title ?? '',
                style: AppTextStyles.headlineSm,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              if (news.description != null) ...[
                Text(
                  news.description!,
                  style: AppTextStyles.bodyMd,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.source?.name ?? 'Unknown Source',
                          style: AppTextStyles.labelMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (news.publishedAt != null)
                          Text(
                            _formatDate(news.publishedAt!),
                            style: AppTextStyles.labelSm,
                          ),
                      ],
                    ),
                  ),
                  // Why listen to BookmarkBloc instead of HeadlinesBloc here?
                  // 1. Separation of Concerns: HeadlinesBloc is solely responsible for fetching and loading news articles.
                  //    It doesn't know or care about which articles are bookmarked. BookmarkBloc keeps track of the active bookmarks list.
                  // 2. Global Reactivity: When we listen to BookmarkBloc here, any addition/removal from *anywhere* in the app
                  //    (like the details screen or the bookmarks screen) will automatically trigger a rebuild of this specific NewsCard
                  //    to show the correct bookmarked state!
                  BlocBuilder<BookmarkBloc, BookmarkState>(
                    builder: (context, state) {
                      bool isBookmarked = false;
                      if (state is BookmarkSuccess) {
                        // Check if the article is already in the bookmarked list by comparing url or title
                        isBookmarked = state.bookmarkedArticles.any(
                          (a) => a.url == news.url && a.title == news.title,
                        );
                      }

                      return IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? AppColors.primary
                              : AppColors.outline,
                        ),
                        onPressed: () {
                          if (!isBookmarked) {
                            context.read<BookmarkBloc>().add(
                              AddToBookmark(news),
                            );
                          } else {
                            // Find the matching article in the list to remove it
                            Article? articleToRemove;
                            if (state is BookmarkSuccess) {
                              try {
                                articleToRemove = state.bookmarkedArticles
                                    .firstWhere(
                                      (a) =>
                                          a.url == news.url &&
                                          a.title == news.title,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateStr;
    }
  }
}
