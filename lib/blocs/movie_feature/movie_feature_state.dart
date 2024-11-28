part of 'movie_feature_bloc.dart';

abstract class MovieFeatureState {}

class MovieFeatureInitial extends MovieFeatureState {}

class MovieLoading extends MovieFeatureState {}

// state for all movie in the home page
class MovieLoaded extends MovieFeatureState {
  final List<MovieModel> movie;

  MovieLoaded(this.movie);
}

class MovieDetailLoaded extends MovieFeatureState {
  final MovieModel movie;

  MovieDetailLoaded(this.movie);
}

// state for successfully loaded search results
class MovieSearchLoaded extends MovieFeatureState {
  final List<MovieModel> movies;

  MovieSearchLoaded(this.movies);
}

class RecentSearchesLoaded extends MovieFeatureState {
  final List<String> recentSearches;

  RecentSearchesLoaded(this.recentSearches);
}

class SearchSuggestionsLoaded extends MovieFeatureState {
  final List<String> suggestions;

  SearchSuggestionsLoaded(this.suggestions);
}

class MovieError extends MovieFeatureState {
  final String message;

  MovieError(this.message);
}
