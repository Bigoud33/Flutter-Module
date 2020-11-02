import 'package:first_app/dataclass.dart';
import 'package:first_app/moviesRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  String movieId;

  DetailsPage({this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<MovieDetails>(
        future: MoviesRepo.fetchMovieById(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              color: Colors.black,
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
            return Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                      snapshot.data.getFullImageUrl(),
                    ),
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: AlignmentDirectional.bottomCenter,
                                  stops: [0, 0.2],
                                  colors: [Colors.transparent, Colors.black])),
                          padding:
                              EdgeInsets.only(left: 10, top: 50, right: 10),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "15+",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    " - ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    snapshot.data.release_date,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    " - ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    snapshot.data.vote_average,
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.genres.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        snapshot.data.genres[index].name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text.rich(TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Cast : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    TextSpan(
                                        text:
                                            "Millie Bobby Brown  Henry Cavill  Sam Clafin  Helena Bonham Carter",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic))
                                  ],
                                )),
                              ),
                              Text(
                                "Summary",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  snapshot.data.overview,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
