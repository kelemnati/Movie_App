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
    on<ToggleFavorite>(_toggleFavorite);
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

  Future<void> _toggleFavorite(
      ToggleFavorite event, Emitter<UserFeatureState> emit) async {
    final currentState = state;
    if (currentState is UserFeaturesLoaded) {
      final isFavorite = currentState.favoriteMovies.contains(event.movieId);
      try {
        if (isFavorite) {
          await userRepository.removeLikedMovie(event.movieId);
          final updatedFavorites =
              List<String>.from(currentState.favoriteMovies)
                ..remove(event.movieId);
          emit(UserFeaturesLoaded(favoriteMovies: updatedFavorites));
          emit(UserFavoriteRemoved());
        } else {
          await userRepository.addLikedMovie(event.movieId);
          final updatedFavorites =
              List<String>.from(currentState.favoriteMovies)
                ..add(event.movieId);
          emit(UserFeaturesLoaded(favoriteMovies: updatedFavorites));
          emit(UserFavoriteAdded());
        }
      } catch (e) {
        emit(UserFeatureError(message: e.toString()));
      }
    }
  }
}
