import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';

import '../../../data/model/news_model.dart';
part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final List<Article> bookmarkedArticles = [];
  // final HeadlinesBloc headlinesBloc; this.headlinesBloc
  BookmarkBloc() : super(BookmarkInitial()) {
    // 1. Why check URL and Title instead of object reference?
    // In a real-world app, news data is fetched from the internet or loaded from local storage
    // multiple times. Every time it is parsed, Dart creates a *new* memory object (a new reference)
    // even if it represents the exact same article. To ensure we correctly identify the same article
    // across different states, we compare unique identifiers (URL & Title) rather than the object memory reference.
    on<AddToBookmark>((event, emit) {
      final exists = bookmarkedArticles.any((a) => a.url == event.article.url && a.title == event.article.title);
      if (!exists) {
        bookmarkedArticles.insert(0, event.article);
      }
      
      // 2. Why use List.from()?
      // Dart lists are passed by reference. If we emit the same 'bookmarkedArticles' list directly,
      // BLoC and Flutter might think the state hasn't changed because the memory address (reference)
      // of the list remains the same, even though we inserted an element. By using List.from(), we
      // create a new list instance (a copy). This guarantees that BLoC detects a state change and
      // reliably triggers a UI rebuild!
      emit(BookmarkSuccess(List.from(bookmarkedArticles)));
    });

    on<RemoveFromBookmark>((event, emit) {
      bookmarkedArticles.removeWhere((a) => a.url == event.article.url && a.title == event.article.title);
      emit(BookmarkSuccess(List.from(bookmarkedArticles)));
    });
  }
}
