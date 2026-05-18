part of 'home_bloc.dart';

@immutable
sealed class HeadlinesEvent {}

class FetchHeadlines extends HeadlinesEvent {
  final String category;
  FetchHeadlines(String category) : category = category ?? '';
}

class ToggleBookmark extends HeadlinesEvent {
  final String category;
  final Article article;
  ToggleBookmark({required this.article, required this.category});
}
