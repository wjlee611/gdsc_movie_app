import 'dart:convert';
import 'package:gdsc_movie_app/constants/api_endpoints.dart';
import 'package:gdsc_movie_app/constants/api_keys.dart';
import 'package:gdsc_movie_app/enums/tmdb_movie_list_type.dart';
import 'package:gdsc_movie_app/models/tmdb/tmdb_movie_list_model.dart';
import 'package:http/http.dart' as http;

class TMDBMovieRepository {
  Future<TMDBMovieListModel?> getMovieList({
    required TMDBMovieListType type,
    int page = 1,
  }) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${ApiKey.tmbdReadAccessToken}',
    };

    final res = await http.get(
      Uri.parse(
          "${ApiEndpoints.tmdbMovieList}/${type.endPoint}?language=en-US&page=$page"),
      headers: headers,
    );

    if (res.statusCode == 200) {
      return TMDBMovieListModel.fromJson(await json.decode(res.body));
    }

    return null;
  }

  Future<TMDBMovieListModel?> getMovieTrendList({
    required TMDBMovieListType type,
  }) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${ApiKey.tmbdReadAccessToken}',
    };

    final res = await http.get(
      Uri.parse(
          "${ApiEndpoints.tmdbMovieTrendList}/${type.endPoint}?language=en-US"),
      headers: headers,
    );

    // For exception test
    // throw Exception('asdasd');

    if (res.statusCode == 200) {
      return TMDBMovieListModel.fromJson(await json.decode(res.body));
    }

    return null;
  }

  Future<TMDBMovieListModel?> getSearchMovie({
    required String query,
    int page = 1,
    bool includeAdult = false,
  }) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${ApiKey.tmbdReadAccessToken}',
    };

    final res = await http.get(
      Uri.parse(
          "${ApiEndpoints.tmdbSearchMovie}?query=$query&include_adult=$includeAdult&language=en-US&page=$page"),
      headers: headers,
    );

    if (res.statusCode == 200) {
      return TMDBMovieListModel.fromJson(await json.decode(res.body));
    }

    return null;
  }
}
