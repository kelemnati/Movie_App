import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/blocs/user_feature/user_feature_bloc.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/widgets/liked_movie_card.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  get movieRepository => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Movies"),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<UserFeatureBloc, UserFeatureState>(
        builder: (context, state) {
          if (state is UserFeatureLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserFeaturesLoaded) {
            final likedMovies = state.favoriteMovies;
            if (likedMovies.isEmpty) {
              return const Center(
                child: Text("No liked movies found."),
              );
            }
            return ListView.builder(
              itemCount: likedMovies.length,
              itemBuilder: (context, index) {
                final movieId = likedMovies[index];
                return FutureBuilder<MovieModel>(
                  future: movieRepository.getMovieDetails(movieId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error loading movie details."),
                      );
                    } else if (snapshot.hasData) {
                      final movie =
                          snapshot.data as MovieModel; // Explicit cast
                      return LikedMovieCard(
                        movieTitle: movie.title,
                        moviePoster: movie.posterPath,
                      );
                    } else {
                      return const Center(
                        child: Text("No data found."),
                      );
                    }
                  },
                );
              },
            );
          } else if (state is UserFeatureError) {
            return Center(
              child: Text("Error: ${state.message}"),
            );
          } else {
            return const Center(
              child: Text("Something went wrong."),
            );
          }
        },
      ),
    );
  }
}
