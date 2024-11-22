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
}
