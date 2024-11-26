part of 'movie_feature_bloc.dart';

abstract class MovieFeatureEvent {}

class FetchPopularMovies extends MovieFeatureEvent {}

class FetchTrendingMovies extends MovieFeatureEvent {}

class FetchTopRatedMovies extends MovieFeatureEvent {}

class FetchMoviesByGenre extends MovieFeatureEvent {
  final int genreId;

  FetchMoviesByGenre(this.genreId);
}
