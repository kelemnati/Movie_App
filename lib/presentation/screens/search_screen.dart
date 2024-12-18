import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      body: Center(
        child: Text(
          "Search Movies",
          style: typography.headlineLarge,
        ),
      ),
    );
  }
}
