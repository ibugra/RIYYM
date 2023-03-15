import 'dart:convert';
import 'package:http/http.dart' as http;

class Movies {
  final int imdbId;
  final String poster;
  final String title;
  final String verticalImg;
  // ignore: non_constant_identifier_names
  final num vote_average;
  final String overview;

  Movies(
      {required this.imdbId,
      required this.title,
      required this.poster,
      required this.verticalImg,
      // ignore: non_constant_identifier_names
      required this.vote_average,
      required this.overview});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
        imdbId: json["id"],
        poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
            json["backdrop_path"],
        title:
            json["title"].toString() == "null" ? json["name"] : json["title"],
        verticalImg: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
            json["poster_path"],
        vote_average: json["vote_average"],
        overview: json["overview"]);
  }
  factory Movies.fromSearchJson(Map<String, dynamic> json) {
    return Movies(
        imdbId: json["id"],
        poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
            json["backdrop_path"],
        title:
            json["title"].toString() == "null" ? json["name"] : json["title"],
        verticalImg: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
            json["poster_path"],
        vote_average: json["vote_average"],
        overview: json["overview"]);
  }
}

class FavoriteMovie {
  final int imdbId;
  final String poster;
  final String title;
  final String year;
  // ignore: non_constant_identifier_names
  final num vote_average;
  final String overview;

  FavoriteMovie(
      {required this.imdbId,
      required this.title,
      required this.poster,
      required this.year,
      // ignore: non_constant_identifier_names
      required this.vote_average,
      required this.overview});

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
        imdbId: json["id"],
        poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
            json["backdrop_path"].toString(),
        title: json["title"].toString() == "null"
            ? json["name"].toString()
            : json["title"].toString(),
        year: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
            json["poster_path"].toString(),
        vote_average: json["vote_average"],
        overview: json["overview"].toString());
  }
}

class Youtube {
  final String name;
  final String key;

  Youtube({
    required this.name,
    required this.key,
  });

  factory Youtube.fromJson(Map<String, dynamic> json) {
    return Youtube(name: json["name"], key: json["key"]);
  }
}

class Search {
  final String name;
  final int key;
  final String poster;
  final String year;
  // ignore: non_constant_identifier_names
  final num vote_average;
  final String overview;

  Search(
      {required this.name,
      required this.key,
      required this.poster,
      required this.year,
      // ignore: non_constant_identifier_names
      required this.vote_average,
      required this.overview});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
        name: json["original_title"].toString(),
        key: json["id"],
        poster: "https://www.themoviedb.org/t/p/w533_and_h300_bestv2" +
            json["poster_path"].toString(),
        year: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
            json["poster_path"].toString(),
        vote_average: json["vote_average"],
        overview: json["overview"].toString());
  }
}

Future<List<Movies>>? fetchAllMovies() async {
  final response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/trending/all/day?api_key=f45ed86c0a3a4ffa16e3d9f8118fc6f8"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list.map((movie) => Movies.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}

Future<List<FavoriteMovie>>? fetchFavorite() async {
  final response = await http
      .get(Uri.parse("https://my-json-server.typicode.com/K0SANUCAK/json/db"));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list
        .map((favoritemovie) => FavoriteMovie.fromJson(favoritemovie))
        .toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}

Future<List<Youtube>>? fetchYoutube(int id) async {
  final response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/movie/$id/videos?api_key=f45ed86c0a3a4ffa16e3d9f8118fc6f8&language=en-US"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    // ignore: prefer_is_empty
    if (list.length < 0) {
      return list.map((youtube) => Youtube.fromJson(youtube)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }
  } else {
    throw Exception("Failed to load movies!");
  }
}

Future<List<Search>>? fetchSearch(String word) async {
  final response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/search/movie?api_key=f45ed86c0a3a4ffa16e3d9f8118fc6f8&language=en-US&query=$word"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list.map((search) => Search.fromJson(search)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}
