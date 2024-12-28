import 'package:flutter/material.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final String title;
  final double rating;
  final MovieModel movieModel;

  const MovieCard({
    super.key,
    required this.posterPath,
    required this.title,
    required this.rating,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: () {
        // Navigate to movie details page when card is tapped
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                      movieModel: movieModel,
                    )));
      },
      child: Container(
        width: 150, // Width of each movie card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.cardBackground,
          boxShadow: [
            BoxShadow(
              color: theme.lineColor.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/$posterPath',
                height: 180,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),

            // Title and Rating
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: theme.typography.bodyMediumWhite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
