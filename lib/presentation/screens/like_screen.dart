import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/blocs/user_feature/user_feature_bloc.dart';
import 'package:movie_app/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/presentation/widgets/liked_movie_card.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserFeatureBloc>().add(FetchFavoriteMovieDetail());

    return Scaffold(
      body: BlocBuilder<UserFeatureBloc, UserFeatureState>(
        builder: (context, state) {
          if (state is UserFeatureLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserFavoriteDetailsLoaded) {
            final likedMovies = state.favoriteMovies;

            // Ensure likedMovies is a list of MovieModel
            if (likedMovies.isEmpty) {
              return const Center(
                child: Text("No liked movies found."),
              );
            }

            return ListView.builder(
              itemCount: likedMovies.length,
              itemBuilder: (context, index) {
                final movie = likedMovies[index];

                // Ensure movie is of type MovieModel
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieModel: movie, // Pass the full MovieModel
                        ),
                      ),
                    );
                  },
                  child: LikedMovieCard(
                    movieTitle: movie.title,
                    moviePoster: movie.posterPath,
                    rating: movie.rating,
                  ),
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
