class TMDBMovieListItemModel {
  final bool? adult;
  final String? backdropPath, posterPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalTitle;
  final String? overview;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;

  TMDBMovieListItemModel({
    this.adult,
    this.backdropPath,
    this.posterPath,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
  });

  factory TMDBMovieListItemModel.fromJson(Map<String, dynamic> json) {
    List<int> genreIds = [];
    for (var id in json['genre_ids']) {
      genreIds.add(id);
    }

    return TMDBMovieListItemModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      genreIds: genreIds,
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
