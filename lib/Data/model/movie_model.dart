class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double rating;
  final String posterPath;
  final List<String> genres;
  final double runtime;
  final String language;

  MovieModel(
      {required this.id,
      required this.title,
      required this.overview,
      required this.releaseDate,
      required this.rating,
      required this.posterPath,
      required this.genres,
      required this.runtime,
      required this.language});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? 'Unknown Title',
      overview: json['overview'] ?? 'No overview available',
      releaseDate: json['release_date'] ?? 'Unknown Release Date',
      rating: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'] ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      runtime: json['runtime'] ?? 0,
      language: json['original_language'] ?? 'Unknown Language',
    );
  }
}
