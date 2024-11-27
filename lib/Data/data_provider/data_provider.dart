import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieService {
  final String? apiKey = dotenv.env['TMDB_API_KEY' ?? ''];

  Future<List<dynamic>> fetchMoviesByGenre(int genreId) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=${dotenv.env['TMDB_API_KEY']}&with_genres=$genreId';
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
        'https://api.themoviedb.org/3/discover/movie?api_key=${dotenv.env['TMDB_API_KEY']}&sort_by=popularity.desc';
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
        'https://api.themoviedb.org/3/trending/movie/$timeWindow?api_key=${dotenv.env['TMDB_API_KEY']}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch trending movies');
    }
  }

  Future<List<dynamic>> fetchTopRatedMovies() async {
    final url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${dotenv.env['TMDB_API_KEY']}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch top-rated movies');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetail(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId?api_key=${dotenv.env['TMDB_API_KEY']}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  Future<List<dynamic>> fetchSearchedMovie(String title) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=${dotenv.env['TMDB_API_KEY']}&query=$title';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to fetch searched movies');
    }
  }
}
