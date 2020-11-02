class GenreList {
  List<Genre> genres;

  GenreList(this.genres);

  factory GenreList.fromJson(Map<String, dynamic> json) {
    List<Genre> tempList = List();
    List<Map<String, dynamic>> jsonGenresList = List.from(json["genres"]);
    for (var i = 0; i < jsonGenresList.length; i++) {
      tempList.add(Genre.fromJson(jsonGenresList[i]));
    }
    return GenreList(tempList);
  }
}

class Genre {
  String id;
  String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"].toString(),
      name: json["name"].toString(),
    );
  }
}

class MoviesListByGenre {
  List<Movie> movies;

  MoviesListByGenre(this.movies);

  factory MoviesListByGenre.fromJson(Map<String, dynamic> json) {
    List<Movie> tempList = List();
    List<Map<String, dynamic>> jsonMoviersList = List.from(json["results"]);
    for (var i = 0; i < jsonMoviersList.length; i++) {
      tempList.add(Movie.fromJson(jsonMoviersList[i]));
    }
    return MoviesListByGenre(tempList);
  }
}

class Movie {
  String id;
  List<int> genre_ids;
  String poster_path;

  Movie({this.id, this.genre_ids, this.poster_path});

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<int> idsList = List.from(json["genre_ids"]);

    return Movie(
      id: json["id"].toString(),
      genre_ids: idsList,
      poster_path: json["poster_path"].toString(),
    );
  }

  String getThumbnailUrl() {
    return "https://image.tmdb.org/t/p/w154" + this.poster_path;
  }
}

class MovieDetails {
  String id;
  String title;
  String overview;
  String release_date;
  String vote_average;
  String poster_path;
  List<Genre> genres;

  MovieDetails({
    this.id,
    this.title,
    this.overview,
    this.release_date,
    this.vote_average,
    this.poster_path,
    this.genres,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    var genreObjsJson = json['genres'] as List;
    List<Genre> _genres =
        genreObjsJson.map((genreJson) => Genre.fromJson(genreJson)).toList();

    return MovieDetails(
      id: json["id"].toString(),
      title: json["title"].toString(),
      overview: json["overview"].toString(),
      genres: _genres,
      vote_average: json["vote_average"].toString(),
      poster_path: json["poster_path"].toString(),
      release_date: json["release_date"].toString(),
    );
  }

  String getFullImageUrl() {
    return "https://image.tmdb.org/t/p/original" + this.poster_path;
  }
}
