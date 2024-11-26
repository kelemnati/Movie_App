import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/Data/repository/user_repo.dart';
// import 'package:equatable/equatable.dart';

part 'user_feature_event.dart';
part 'user_feature_state.dart';

class UserFeatureBloc extends Bloc<UserFeatureEvent, UserFeatureState> {
  final UserRepository userRepository;
  UserFeatureBloc({required this.userRepository})
      : super(UserFeatureInitial()) {
    on<FetchLikedMovies>(_fetchLikedMovies);
    on<AddLikedMovie>(_addLikedMovies);
  }

  FutureOr<void> _fetchLikedMovies(
      FetchLikedMovies event, Emitter<UserFeatureState> emit) async {
    emit(LikedMoviesLoading());
    try {
      final likedMovies = await userRepository.fetchLikedMovies();
      emit(LikedMoviesLoaded(likedMovies));
    } catch (e) {
      emit(LikedMoviesError(e.toString()));
    }
  }

  FutureOr<void> _addLikedMovies(
      AddLikedMovie event, Emitter<UserFeatureState> emit) async {
    try {
      await userRepository.addLikedMovie(event.movieId);
      add(FetchLikedMovies());
    } catch (e) {
      emit(LikedMoviesError(e.toString()));
    }
  }
}
