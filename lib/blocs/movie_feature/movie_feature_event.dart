part of 'movie_feature_bloc.dart';

abstract class MovieFeatureEvent {}

class FetchAllMovies extends MovieFeatureEvent {}

class FetchMoviesByGenre extends MovieFeatureEvent {
  final int genreId;

  FetchMoviesByGenre(this.genreId);
}

class FetchMovieDetail extends MovieFeatureEvent {
  final int movieId;

  FetchMovieDetail(this.movieId);
}

class FetchRecentSearches extends MovieFeatureEvent {}

class FetchSearchSuggestions extends MovieFeatureEvent {}

class SearchMovies extends MovieFeatureEvent {
  final String query;
  final int? genreId;
  final double? minRating;
  final double? maxRating;
  final String? language;
  final String? sortBy;
  final int? releaseYear;
  final DateTime? releaseDateStart;
  final DateTime? releaseDateEnd;
  final List<int>? castIds; // Actor IDs
  final List<int>? crewIds; // Crew IDs
  final List<int>? keywordIds; // Keyword IDs
  final List<int>? companyIds; // Company IDs
  final String? region;
  final List<int>? watchProviderIds; // Streaming platforms

  SearchMovies({
    required this.query,
    this.genreId,
    this.minRating,
    this.maxRating,
    this.language,
    this.sortBy,
    this.releaseYear,
    this.releaseDateStart,
    this.releaseDateEnd,
    this.castIds,
    this.crewIds,
    this.keywordIds,
    this.companyIds,
    this.region,
    this.watchProviderIds,
  });
}

class AddToRecentSearches extends MovieFeatureEvent {
  final String query;

  AddToRecentSearches(this.query);
}
