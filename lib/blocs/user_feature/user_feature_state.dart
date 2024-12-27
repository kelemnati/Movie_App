part of 'user_feature_bloc.dart';

abstract class UserFeatureState {}

class UserFeatureInitial extends UserFeatureState {}

class UserFeatureLoading extends UserFeatureState {}

class UserFavoriteDetailsLoaded extends UserFeatureState {
  final List<MovieModel> favoriteMovies;

  UserFavoriteDetailsLoaded({required this.favoriteMovies});
}

class UserFeaturesLoaded extends UserFeatureState {
  final List<String> favoriteMovies;

  UserFeaturesLoaded({required this.favoriteMovies});
}

class UserFavoriteAdded extends UserFeatureState {}

class UserFavoriteRemoved extends UserFeatureState {}

class UserFeatureError extends UserFeatureState {
  final String message;

  UserFeatureError({required this.message});
}
