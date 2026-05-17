part of 'home_bloc.dart';

@immutable
sealed class HeadlinesEvent {}

class FetchHeadlines extends HeadlinesEvent {
  final String category;
  FetchHeadlines(category) : category = category ?? '';
}
