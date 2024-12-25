import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/repository/user_repo.dart';

part 'user_feature_event.dart';
part 'user_feature_state.dart';

class UserFeatureBloc extends Bloc<UserFeatureEvent, UserFeatureState> {
  final UserRepository userRepository;

  UserFeatureBloc({required this.userRepository})
      : super(UserFeatureInitial()) {
    on<FetchFavorites>(_fetchFavorites);
    on<AddFavorite>(_addFavorite);
    on<RemoveFavorite>(_removeFavorite);
  }

  Future<void> _fetchFavorites(
      FetchFavorites event, Emitter<UserFeatureState> emit) async {
    emit(UserFeatureLoading());
    try {
      final favoriteMovies = await userRepository.fetchLikedMovies();
      emit(UserFeaturesLoaded(favoriteMovies: favoriteMovies));
    } catch (e) {
      emit(UserFeatureError(message: e.toString()));
    }
  }

  Future<void> _addFavorite(
      AddFavorite event, Emitter<UserFeatureState> emit) async {
    try {
      await userRepository.addLikedMovie(event.movieId);
      final currentState = state;
      if (currentState is UserFeaturesLoaded) {
        final updatedFavorites = List<String>.from(currentState.favoriteMovies)
          ..add(event.movieId);
        emit(UserFeaturesLoaded(favoriteMovies: updatedFavorites));
      }
      emit(UserFavoriteAdded());
    } catch (e) {
      emit(UserFeatureError(message: e.toString()));
    }
  }

  Future<void> _removeFavorite(
      RemoveFavorite event, Emitter<UserFeatureState> emit) async {
    try {
      await userRepository.removeLikedMovie(event.movieId);
      final currentState = state;
      if (currentState is UserFeaturesLoaded) {
        final updatedFavorites = List<String>.from(currentState.favoriteMovies)
          ..remove(event.movieId);
        emit(UserFeaturesLoaded(favoriteMovies: updatedFavorites));
      }
      emit(UserFavoriteRemoved());
    } catch (e) {
      emit(UserFeatureError(message: e.toString()));
    }
  }
}
