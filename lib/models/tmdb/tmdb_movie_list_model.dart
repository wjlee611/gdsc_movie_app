import 'package:gdsc_movie_app/models/tmdb/tmdb_movie_listitem_model.dart';

// TODO: json_serializable, equatable
class TMDBMovieListModel {
  final int? page;
  final List<TMDBMovieListItemModel>? results;
  final int? totalPages;
  final int? totalResults;

  TMDBMovieListModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TMDBMovieListModel.fromJson(Map<String, dynamic> json) {
    List<TMDBMovieListItemModel> results = [];
    for (var movie in json['results']) {
      results.add(TMDBMovieListItemModel.fromJson(movie));
    }

    return TMDBMovieListModel(
      page: json['page'],
      results: results,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
