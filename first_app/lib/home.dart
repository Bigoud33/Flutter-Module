import 'package:first_app/details.dart';
import 'package:first_app/moviesRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dataclass.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<GenreList>(
        future: MoviesRepo.fetchGenresList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Text("Loading"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Container(
              color: Colors.black,
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.genres.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data.genres[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      FutureBuilder<MoviesListByGenre>(
                        future: MoviesRepo.fetchMoviesByGenre(
                            snapshot.data.genres[index].id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Container(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "Loading",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.movies.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, right: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image(
                                          image: NetworkImage(
                                            snapshot.data.movies[index]
                                                .getThumbnailUrl(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  movieId: snapshot
                                                      .data.movies[index].id)));
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Categorie extends StatelessWidget {
  Categorie(String categorieName, List<String> movies) {
    this.categorieName = categorieName;
    this.movies = movies;
  }

  String categorieName;
  List<String> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            categorieName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Text(
                movies[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
