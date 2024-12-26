import 'package:flutter/material.dart';

class LikedMovieCard extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;

  const LikedMovieCard({
    super.key,
    required this.movieTitle,
    required this.moviePoster,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Movie image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$moviePoster',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
            ),
          ),
          // Movie details or actions
          Container(
            height: 50,
            color: Colors.red.withOpacity(0.9),
            child: Center(
              child: Text(
                movieTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
