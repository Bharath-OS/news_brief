part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent {}

final class BookmarkArticle extends BookmarkEvent {
  final Article article;
  BookmarkArticle(this.article);
}

final class AddToBookmark extends BookmarkEvent {
  final Article article;
  AddToBookmark(this.article);
}

final class RemoveFromBookmark extends BookmarkEvent {
  final Article article;
  RemoveFromBookmark(this.article);
}
