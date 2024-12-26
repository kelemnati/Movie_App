import 'package:movie_app/Data/data_provider/data_provider.dart';
import 'package:movie_app/Data/model/movie_model.dart';

class MovieRepository {
  final MovieService dataProvider;

  MovieRepository({required this.dataProvider});

  List<MovieModel> _convertToMovieModels(List<dynamic> data) {
    return data
        .map<MovieModel>(
            (movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
        .toList();
  }

  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final data = await dataProvider.fetchMoviesByGenre(genreId);
    return _convertToMovieModels(data);
  }

  Future<List<MovieModel>> getMoviesByPopularity() async {
    final data = await dataProvider.fetchMoviesByPopularity();
    return data
        .map<MovieModel>(
            (movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
        .toList();
  }

  Future<List<MovieModel>> getMoviesByTrending(String timeWindow) async {
    final data = await dataProvider.fetchTrendingMovies(timeWindow);
    return _convertToMovieModels(data);
  }

  Future<List<MovieModel>> getMoviesByRating() async {
    final data = await dataProvider.fetchTopRatedMovies();
    return _convertToMovieModels(data);
  }

  Future<MovieModel> getMovieDetail(int movieId) async {
    final data = await dataProvider.fetchMovieDetail(movieId);
    return MovieModel.fromJson(data);
  }

  Future<List<MovieModel>> searchMovies({
    required String query,
    int? genreId,
    double? minRating,
    double? maxRating,
    String? language,
    String? sortBy,
    int? releaseYear,
    DateTime? releaseDateStart,
    DateTime? releaseDateEnd,
    List<int>? castIds,
    List<int>? crewIds,
    List<int>? keywordIds,
    List<int>? companyIds,
    String? region,
    List<int>? watchProviderIds,
  }) async {
    final data = await dataProvider.searchMovies(
      query: query,
      genreId: genreId,
      minRating: minRating,
      maxRating: maxRating,
      language: language,
      sortBy: sortBy,
      releaseYear: releaseYear,
      releaseDateStart: releaseDateStart,
      releaseDateEnd: releaseDateEnd,
      castIds: castIds,
      crewIds: crewIds,
      keywordIds: keywordIds,
      companyIds: companyIds,
      region: region,
      watchProviderIds: watchProviderIds,
    );
    return _convertToMovieModels(data);
  }

  Future<MovieModel> getMovieDetails(String movieId) async {
    try {
      final response = await dataProvider.fetchMovieDetails(movieId);
      return MovieModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch movie details: $e");
    }
  }
}
