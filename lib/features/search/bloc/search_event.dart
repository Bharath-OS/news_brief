import '../../../data/model/news_model.dart';

abstract class SearchEvent {}

class InitEvent extends SearchEvent {}

class SearchArticle extends SearchEvent {
  final String query;
  SearchArticle(this.query);
}

class AddToRecent extends SearchEvent {
  final Article recentArticle;
  AddToRecent(this.recentArticle);
}
