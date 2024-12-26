part of 'movie_feature_bloc.dart';

abstract class MovieFeatureState {}

class MovieFeatureInitial extends MovieFeatureState {}

class MovieLoading extends MovieFeatureState {}

class PopularMoviesLoading extends MovieFeatureState {}

class TrendingMoviesLoading extends MovieFeatureState {}

class TopRatedMoviesLoading extends MovieFeatureState {}

class PopularMoviesLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  PopularMoviesLoaded(this.movies);
}

class TrendingMoviesLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  TrendingMoviesLoaded(this.movies);
}

class TopRatedMoviesLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  TopRatedMoviesLoaded(this.movies);
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
