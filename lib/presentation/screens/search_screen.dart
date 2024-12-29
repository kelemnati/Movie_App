import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/blocs/movie_feature/movie_feature_bloc.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
import 'package:movie_app/presentation/widgets/search_movie_card.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search movie title...",
            // hintStyle: TextStyle(color: theme.hintColor),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: theme.iconTheme.color),
              onPressed: () {
                final query = searchController.text.trim();
                if (query.isNotEmpty) {
                  context
                      .read<MovieFeatureBloc>()
                      .add(SearchMovies(query: query));
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<MovieFeatureBloc, MovieFeatureState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return _buildShimmerEffect();
          } else if (state is MovieSearchLoaded) {
            return _buildSearchResults(state.movies);
          } else if (state is MovieError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            );
          }
          return Center(
            child: Text(
              "Search for your favorite movies!",
              style: TextStyle(color: theme.textTheme.bodySmall?.color),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(List<MovieModel> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return SearchMovieCard(
          movieTitle: movie.title,
          moviePoster: movie.posterPath,
        );
      },
    );
  }
}
