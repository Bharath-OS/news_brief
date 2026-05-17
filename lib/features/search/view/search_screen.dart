import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/utils/dummy_data.dart';
import 'package:news_app/core/widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to SearchBloc here
    final searchResults = DummyData.newsList.take(2).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for articles...',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                // TODO: Dispatch search event to bloc
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Recent Searches', style: AppTextStyles.headlineSm),
          ),
          // TODO: Build actual search results using BlocBuilder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return NewsCard(news: searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
