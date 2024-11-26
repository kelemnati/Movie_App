part of 'user_feature_bloc.dart';

abstract class UserFeatureState {}

class UserFeatureInitial extends UserFeatureState {}

class LikedMoviesInitial extends UserFeatureState {}

class LikedMoviesLoading extends UserFeatureState {}

class LikedMoviesLoaded extends UserFeatureState {
  final List<String> likedMovies;

  LikedMoviesLoaded(this.likedMovies);
}

class LikedMoviesError extends UserFeatureState {
  final String message;

  LikedMoviesError(this.message);
}
