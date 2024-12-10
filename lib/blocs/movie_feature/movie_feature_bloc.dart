import 'dart:async';

// ignore: depend_on_referenced_packages
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
    on<FetchMovieDetail>(_fetchMovieDetail);
    on<SearchMovies>(_searchMovies);
    on<FetchRecentSearches>(_fetchRecentSearches);
    on<FetchSearchSuggestions>(_fetchSearchSuggestions);
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

// to fetch movie detail when the user clicked(tap) on movie poster
  FutureOr<void> _fetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movieDetail = await movieRepository.getMovieDetail(event.movieId);
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  FutureOr<void> _searchMovies(
      SearchMovies event, Emitter<MovieFeatureState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.searchMovies(
        query: event.query,
        genreId: event.genreId,
        minRating: event.minRating,
        maxRating: event.maxRating,
        language: event.language,
        sortBy: event.sortBy,
        releaseYear: event.releaseYear,
        releaseDateStart: event.releaseDateStart,
        releaseDateEnd: event.releaseDateEnd,
        castIds: event.castIds,
        crewIds: event.crewIds,
        keywordIds: event.keywordIds,
        companyIds: event.companyIds,
        region: event.region,
        watchProviderIds: event.watchProviderIds,
      );
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  FutureOr<void> _fetchRecentSearches(
      FetchRecentSearches event, Emitter<MovieFeatureState> emit) {}

  FutureOr<void> _fetchSearchSuggestions(
      FetchSearchSuggestions event, Emitter<MovieFeatureState> emit) {}
}
