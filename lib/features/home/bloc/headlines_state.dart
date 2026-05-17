part of 'home_bloc.dart';

@immutable
sealed class HeadlinesState {}

final class HeadlinesInitial extends HeadlinesState {}

final class HeadlinesLoading extends HeadlinesState {}

final class HeadlinesSuccess extends HeadlinesState {
  final List<Article> articles;
  final String category;
  HeadlinesSuccess({required this.category, required this.articles});
}

final class HeadlinesFailure extends HeadlinesState {
  final String message;
  final String category;
  HeadlinesFailure(this.message, this.category);
}
