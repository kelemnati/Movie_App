import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/blocs/user_feature/user_feature_bloc.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetailScreen({
    super.key,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context) {
    // Trigger the fetch event to ensure the current favorites are loaded
    context.read<UserFeatureBloc>().add(FetchFavorites());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocConsumer<UserFeatureBloc, UserFeatureState>(
            listener: (context, state) {
              if (state is UserFavoriteAdded) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${movieModel.title} has been added to your favorites."),
                ));
              } else if (state is UserFavoriteRemoved) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${movieModel.title} has been removed from your favorites."),
                ));
              }
            },
            builder: (context, state) {
              // Determine if the movie is a favorite
              final isFavorite = state is UserFeaturesLoaded &&
                  state.favoriteMovies.contains(movieModel.id.toString());

              return IconButton(
                onPressed: () {
                  context
                      .read<UserFeatureBloc>()
                      .add(ToggleFavorite(movieId: movieModel.id.toString()));
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.red,
                iconSize: 32,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/${movieModel.posterPath}",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 150,
                ),
              ),
            ),
            const VerticalSpacer(height: 15),
            // Movie Information
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movieModel.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalSpacer(height: 8),
                  // Release Date
                  Text(
                    "Release Date: ${movieModel.releaseDate}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSpacer(height: 8),
                  // Overview
                  Text(
                    movieModel.overview,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSpacer(height: 20),
                  // Rating
                  Text(
                    "Rating: ${movieModel.rating}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSpacer(height: 20),
                  // Genres
                  Text(
                    "Genres: ${movieModel.genres.isNotEmpty ? movieModel.genres.join(", ") : "N/A"}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSpacer(height: 20),
                  // Divider
                  const Divider(color: Colors.black),
                  const VerticalSpacer(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
