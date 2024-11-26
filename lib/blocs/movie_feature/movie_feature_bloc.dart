import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/Data/repository/movie_repo.dart';

part 'movie_feature_event.dart';
part 'movie_feature_state.dart';

class MovieFeatureBloc extends Bloc<MovieFeatureEvent, MovieFeatureState> {
  final MovieRepository movieRepository;
  MovieFeatureBloc({required this.movieRepository})
      : super(MovieFeatureInitial()) {
    on<FetchPopularMovies>(_fetchPopularMovies);
    on<FetchTrendingMovies>(_fetchTrendingMovies);
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
    on<FetchMoviesByGenre>(_fetchMoviesByGenre);
  }

  FutureOr<void> _fetchPopularMovies(
      FetchPopularMovies event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMoviesByPopularity();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  FutureOr<void> _fetchTrendingMovies(
      FetchTrendingMovies event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMoviesByTrending('day');
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  FutureOr<void> _fetchTopRatedMovies(
      FetchTopRatedMovies event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMoviesByRating();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  FutureOr<void> _fetchMoviesByGenre(
      FetchMoviesByGenre event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMoviesByGenre(event.genreId);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
