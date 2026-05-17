import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/features/main/view/main_screen.dart';
import '../../../core/constats/app_constants.dart';
import '../../home/bloc/home_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HeadlinesBloc>().add(FetchHeadlines(''));
  }

  void _navigateToMain() async {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.read<HeadlinesBloc>().add(FetchHeadlines());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath),
              const SizedBox(height: 16),
              Text(
                'NewsBrief',
                style: AppTextStyles.headlineLg.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<HeadlinesBloc, HeadlinesState>(
        listener: (context, state) {
          if (state is! HeadlinesLoading) {
            _navigateToMain();
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 50,
                  child: LinearProgressIndicator(color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Text('Loading the latest news...', style: AppTextStyles.bodyMd),
              ],
            ),
          );
        },
      ),
    );
  }
}
