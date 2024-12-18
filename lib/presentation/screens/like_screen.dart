import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/app_theme.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Center(
      child: Text(
        "Your Liked Movies",
        style: typography.headlineLarge,
      ),
    );
  }
}
