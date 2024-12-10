import 'package:flutter/material.dart';
// import 'movie_card.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
import 'package:movie_app/presentation/widgets/movie_card_widget.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies; // Updated to use MovieModel

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacer(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: typography.headlineMedium,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 240, // Adjust based on MovieCard height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: MovieCard(
                  posterPath: movie.posterPath, // MovieModel property
                  title: movie.title, // MovieModel property
                  rating: movie.rating, // MovieModel property
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
