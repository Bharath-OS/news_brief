import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/widgets/news_card.dart';
import 'package:news_app/features/home/widgets/category_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'For You',
    'Technology',
    'Science',
    'Sports',
    'Business',
    'Health',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Implement BlocBuilder to load real news data based on selected category
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NewsBrief',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<HeadlinesBloc, HeadlinesState>(
        builder: (context, state) {
          if (state is HeadlinesSuccess) {
            return Column(
              children: [
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return CategoryChip(
                        label: _categories[index],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () {
                          _selectedCategoryIndex = index;
                          context.read<HeadlinesBloc>().add(
                            FetchHeadlines(
                              _categories[index] == 'For You'
                                  ? ''
                                  : _categories[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: state.articles[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is HeadlinesFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
