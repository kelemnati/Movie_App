part of 'movie_feature_bloc.dart';

abstract class MovieFeatureState {}

class MovieFeatureInitial extends MovieFeatureState {}

class MovieLoading extends MovieFeatureState {}

class MovieLoaded extends MovieFeatureState {
  final List<MovieModel> movie;

  MovieLoaded(this.movie);
}

class MovieError extends MovieFeatureState {
  final String message;

  MovieError(this.message);
}
