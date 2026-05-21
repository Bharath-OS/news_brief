import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/features/bookmarks/bloc/bookmark_bloc.dart';
import 'package:news_app/features/news_details/view/news_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/news_model.dart';

class NewsCard extends StatelessWidget {
  final Article news;
  final VoidCallback? onPressed;
  final bool isExpanded;

  const NewsCard({
    super.key,
    required this.news,
    this.onPressed,
    this.isExpanded = false,
  });

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
      child: isExpanded ? _buildExpandedCard() : _buildCompactCard(),
    );
  }

  Widget _buildExpandedCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: news.title!,
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? '',
                  memCacheHeight: 180,
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
            ),
            if (news.urlToImage != null) const SizedBox(height: 12),
            Text(
              news.title ?? '',
              style: AppTextStyles.headlineSm.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
                        color: isBookmarked
                            ? AppColors.primary
                            : AppColors.outline,
                      ),
                      onPressed: () {
                        if (!isBookmarked) {
                          context.read<BookmarkBloc>().add(AddToBookmark(news));
                        } else {
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
    );
  }

  Widget _buildCompactCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Left side square thumbnail image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                memCacheHeight: 100,
                memCacheWidth: 100,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  height: 100,
                  width: 100,
                  color: AppColors.surfaceContainer,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.outline,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 2. Right side text and metadata
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title of the news article
                    Text(
                      news.title ?? '',
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Bottom Row: Source, dot, Date, and Bookmark icon
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  news.source?.name ?? 'Unknown Source',
                                  style: AppTextStyles.labelMd.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (news.publishedAt != null) ...[
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.fiber_manual_record,
                                  size: 4,
                                  color: AppColors.outline,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _formatDate(news.publishedAt!),
                                  style: AppTextStyles.labelSm,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Bookmark Button
                        BlocBuilder<BookmarkBloc, BookmarkState>(
                          builder: (context, state) {
                            bool isBookmarked = false;
                            if (state is BookmarkSuccess) {
                              isBookmarked = state.bookmarkedArticles.any(
                                (a) =>
                                    a.url == news.url && a.title == news.title,
                              );
                            }
                            return SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  size: 20,
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
                                    Article? articleToRemove;
                                    if (state is BookmarkSuccess) {
                                      try {
                                        articleToRemove = state
                                            .bookmarkedArticles
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
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
