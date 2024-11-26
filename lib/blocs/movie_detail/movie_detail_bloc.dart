import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/Data/repository/movie_repo.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;
  MovieDetailBloc({required this.movieRepository})
      : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_fetchMovieDetail);
  }

  FutureOr<void> _fetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      emit(MovieDetailLoading());
      final movieDetail = await movieRepository.getMovieById();
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
