import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/secret_key.dart';

class MovieService {
  final String apiKey = Keys.TMDB_API_KEY;

  Future<List<dynamic>> fetchMoviesByGenre(int genreId) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch movies by genre');
    }
  }

  Future<List<dynamic>> fetchMoviesByPopularity() async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to fetch popular movies");
    }
  }

  Future<List<dynamic>> fetchTrendingMovies(String timeWindow) async {
    final url =
        'https://api.themoviedb.org/3/trending/movie/$timeWindow?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch trending movies');
    }
  }

  Future<List<dynamic>> fetchTopRatedMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch top-rated movies');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetail(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  Future<List<dynamic>> searchMovies({
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
    final queryParameters = {
      'api_key': apiKey,
      'query': query,
      if (genreId != null) 'with_genres': genreId.toString(),
      if (minRating != null) 'vote_average.gte': minRating.toString(),
      if (maxRating != null) 'vote_average.lte': maxRating.toString(),
      if (language != null) 'with_original_language': language,
      if (sortBy != null) 'sort_by': sortBy,
      if (releaseYear != null) 'primary_release_year': releaseYear.toString(),
      if (releaseDateStart != null)
        'primary_release_date.gte': releaseDateStart.toIso8601String(),
      if (releaseDateEnd != null)
        'primary_release_date.lte': releaseDateEnd.toIso8601String(),
      if (castIds != null) 'with_cast': castIds.join(','),
      if (crewIds != null) 'with_crew': crewIds.join(','),
      if (keywordIds != null) 'with_keywords': keywordIds.join(','),
      if (companyIds != null) 'with_companies': companyIds.join(','),
      if (region != null) 'region': region,
      if (watchProviderIds != null)
        'with_watch_providers': watchProviderIds.join(','),
    };

    final uri =
        Uri.https('api.themoviedb.org', '/3/search/movie', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
