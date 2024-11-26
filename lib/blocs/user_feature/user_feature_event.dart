part of 'user_feature_bloc.dart';

abstract class UserFeatureEvent {}

class FetchLikedMovies extends UserFeatureEvent {}

class AddLikedMovie extends UserFeatureEvent {
  final String movieId;

  AddLikedMovie(this.movieId);
}
