import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/model/news_model.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Article> recentArticles = [];
  final NewsRepository _repository;

  SearchBloc(this._repository) : super(SearchRecent([])) {
    on<InitEvent>(_init);
    on<SearchArticle>(
      _searchArticles,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AddToRecent>(_addToRecent);
  }

  void _init(InitEvent event, Emitter<SearchState> emit) async {
    emit(SearchRecent(recentArticles));
  }

  void _addToRecent(AddToRecent event, Emitter<SearchState> emit) {
    recentArticles.removeWhere(
      (a) =>
          a.url == event.recentArticle.url &&
          a.title == event.recentArticle.title,
    );
    recentArticles.insert(0, event.recentArticle);
    // Optional: Limit list to last 10 searches to prevent memory bloat
    if (recentArticles.length > 10) {
      recentArticles.removeLast();
    }
    if (state is SearchRecent) {
      emit(SearchRecent(List.from(recentArticles)));
    }
  }

  void _searchArticles(SearchArticle event, Emitter<SearchState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(SearchRecent(recentArticles));
      return;
    }
    emit(SearchLoading());
    try {
      final searchResults = await _repository.searchArticles(event.query);
      emit(SearchSuccess(searchResults));
    } catch (error) {
      emit(SearchFailure(error.toString()));
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
