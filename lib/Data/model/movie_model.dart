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

  // Optional fields for search functionality
  final double? minRating;
  final double? maxRating;
  final String? sortBy;
  final int? releaseYear;
  final DateTime? releaseDateStart;
  final DateTime? releaseDateEnd;
  final List<int>? castIds;
  final List<int>? crewIds;
  final List<int>? keywordIds;
  final List<int>? companyIds;
  final String? region;
  final List<int>? watchProviderIds;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.posterPath,
    required this.genres,
    required this.runtime,
    required this.language,
    this.minRating,
    this.maxRating,
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

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Unknown Title',
      overview: json['overview'] as String? ?? 'No overview available',
      releaseDate: json['release_date'] as String? ?? 'Unknown Release Date',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      runtime: (json['runtime'] as num?)?.toDouble() ?? 0.0,
      language: json['original_language'] as String? ?? 'Unknown Language',

      // Optional fields
      minRating: (json['min_rating'] as num?)?.toDouble(),
      maxRating: (json['max_rating'] as num?)?.toDouble(),
      sortBy: json['sort_by'] as String?,
      releaseYear: json['release_year'] as int?,
      releaseDateStart: json['release_date_start'] != null
          ? DateTime.tryParse(json['release_date_start'])
          : null,
      releaseDateEnd: json['release_date_end'] != null
          ? DateTime.tryParse(json['release_date_end'])
          : null,
      castIds:
          (json['cast_ids'] as List<dynamic>?)?.map((id) => id as int).toList(),
      crewIds:
          (json['crew_ids'] as List<dynamic>?)?.map((id) => id as int).toList(),
      keywordIds: (json['keyword_ids'] as List<dynamic>?)
          ?.map((id) => id as int)
          .toList(),
      companyIds: (json['company_ids'] as List<dynamic>?)
          ?.map((id) => id as int)
          .toList(),
      region: json['region'] as String?,
      watchProviderIds: (json['watch_provider_ids'] as List<dynamic>?)
          ?.map((id) => id as int)
          .toList(),
    );
  }
}
