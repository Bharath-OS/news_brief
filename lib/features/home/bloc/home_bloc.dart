import 'package:news_app/data/model/news_model.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'headlines_event.dart';
part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  final NewsRepository repository;
  final Map<String, List<Article>> cache = {};

  HeadlinesBloc(this.repository) : super(HeadlinesInitial()) {
    on<FetchHeadlines>(_fetchTopHeadlines);
  }

  Future<void> _fetchTopHeadlines(
    FetchHeadlines event,
    Emitter<HeadlinesState> emit,
  ) async {
    if (cache.containsKey(event.category)) {
      emit(
        HeadlinesSuccess(
          category: event.category,
          articles: cache[event.category]!,
        ),
      );
      return;
    }
    emit(HeadlinesLoading());
    try {
      final articles = await repository.fetchNews(event.category);
      cache[event.category] = articles;
      emit(HeadlinesSuccess(articles: articles, category: event.category));
    } catch (error) {
      emit(HeadlinesFailure(error.toString(), event.category));
    }
  }
}
