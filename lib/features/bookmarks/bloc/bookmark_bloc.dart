import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import '../../../data/model/news_model.dart';
part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final List<Article> bookmarkedArticles = [];
  BookmarkBloc() : super(BookmarkInitial()) {
    on<AddToBookmark>((event, emit) {
      final exists = bookmarkedArticles.any(
        (a) => a.url == event.article.url && a.title == event.article.title,
      );
      if (!exists) {
        bookmarkedArticles.insert(0, event.article);
      }
      emit(BookmarkSuccess(List.from(bookmarkedArticles)));
    });

    on<RemoveFromBookmark>((event, emit) {
      bookmarkedArticles.removeWhere(
        (a) => a.url == event.article.url && a.title == event.article.title,
      );
      emit(BookmarkSuccess(List.from(bookmarkedArticles)));
    });
  }
}
