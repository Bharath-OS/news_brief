part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookmarkLoading extends BookmarkState {}

final class BookmarkSuccess extends BookmarkState {
  final List<Article> bookmarkedArticles;
  BookmarkSuccess(this.bookmarkedArticles);
}

final class BookmarkFailure extends BookmarkState {
  final String message;
  BookmarkFailure(this.message);
}
