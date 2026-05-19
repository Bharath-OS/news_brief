import 'package:news_app/data/model/news_model.dart';

class SearchState {
  // List<Article> recents = [];
  // SearchState([this.recents = const []]);
  SearchState init() {
    return SearchState();
  }

  SearchState clone() {
    return SearchState();
  }
}

class SearchRecent extends SearchState {
  final List<Article> recents;
  SearchRecent(this.recents);
}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Article> searchResults;
  SearchSuccess(this.searchResults);
}

class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}
