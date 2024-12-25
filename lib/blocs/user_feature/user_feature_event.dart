part of 'user_feature_bloc.dart';

abstract class UserFeatureEvent {}

class FetchFavorites extends UserFeatureEvent {}

class AddFavorite extends UserFeatureEvent {
  final String movieId;

  AddFavorite({required this.movieId});
}

class RemoveFavorite extends UserFeatureEvent {
  final String movieId;

  RemoveFavorite({required this.movieId});
}

class ToggleFavorite extends UserFeatureEvent {
  final String movieId;

  ToggleFavorite({required this.movieId});
}
