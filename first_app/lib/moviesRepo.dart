import 'dart:convert';

import 'package:first_app/dataclass.dart';
import 'package:http/http.dart' as http;

class MoviesRepo {
  static Future<GenreList> fetchGenresList() async {
    String url =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=62feaff3d2cf094a340f530fbf25bde9&language=fr";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return GenreList.fromJson(jsonDecode(response.body));
    }
  }

  static Future<MoviesListByGenre> fetchMoviesByGenre(String id) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=62feaff3d2cf094a340f530fbf25bde9&with_genres=$id&language=fr";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MoviesListByGenre.fromJson(jsonDecode(response.body));
    }
  }

  static Future<MovieDetails> fetchMovieById(String id) async {
    String url =
        "https://api.themoviedb.org/3/movie/$id?api_key=62feaff3d2cf094a340f530fbf25bde9&language=fr";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieDetails.fromJson(jsonDecode(response.body));
    }
  }
}
