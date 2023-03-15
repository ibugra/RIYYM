import 'package:flutter/material.dart';

import 'movie_api.dart';

import 'package:url_launcher/url_launcher.dart';

class DetailMoviePage extends StatefulWidget {
  final Movies movie;

  // ignore: use_key_in_widget_constructors
  const DetailMoviePage(this.movie);
  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  void customLaunch(command) async {
    await launch(command, forceSafariVC: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.movie.poster,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          widget.movie.vote_average.toString(),
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ...List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: (index <
                                    (widget.movie.vote_average / 2).floor())
                                ? Colors.yellow
                                : Colors.white30,
                          ),
                        ),
                        FutureBuilder<List<Youtube>>(
                            future: fetchYoutube(widget.movie.imdbId),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return IconButton(
                                  onPressed: () {
                                    customLaunch(
                                        "https://www.youtube.com/results?search_query=${widget.movie.title} trailer");
                                  },
                                  icon: const Icon(Icons.play_circle_outlined),
                                  iconSize: 40,
                                  color: Colors.blue,
                                );
                              } else if (snapshot.hasData) {
                                String link = "https://youtube.com/watch?v=" +
                                    snapshot.data![0].key;
                                return IconButton(
                                  onPressed: () {
                                    customLaunch(link);
                                  },
                                  icon: const Icon(Icons.play_circle_outlined),
                                  iconSize: 40,
                                  color: Colors.blue,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
