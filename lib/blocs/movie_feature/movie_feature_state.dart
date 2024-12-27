part of 'movie_feature_bloc.dart';

abstract class MovieFeatureState {}

class MovieFeatureInitial extends MovieFeatureState {}

class MovieLoading extends MovieFeatureState {}

class MovieFeatureLoaded extends MovieFeatureState {
  final List<MovieModel> popularMovies;
  final List<MovieModel> trendingMovies;
  final List<MovieModel> topRatedMovies;

  MovieFeatureLoaded({
    required this.popularMovies,
    required this.trendingMovies,
    required this.topRatedMovies,
  });
}

// State for all movies in the home page (generalized state)
class MovieLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  MovieLoaded(this.movies);
}

// State for Movie Details
class MovieDetailLoaded extends MovieFeatureState {
  final MovieModel movie;

  MovieDetailLoaded(this.movie);
}

// State for successfully loaded search results
class MovieSearchLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  MovieSearchLoaded(this.movies);
}

// State for recent searches
class RecentSearchesLoaded extends MovieFeatureState {
  final List<String> recentSearches;

  RecentSearchesLoaded(this.recentSearches);
}

// State for search suggestions
class SearchSuggestionsLoaded extends MovieFeatureState {
  final List<String> suggestions;

  SearchSuggestionsLoaded(this.suggestions);
}

// State for errors
class MovieError extends MovieFeatureState {
  final String message;

  MovieError(this.message);
}
