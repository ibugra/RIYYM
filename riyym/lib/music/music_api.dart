import 'dart:convert';
import 'package:http/http.dart' as http;

class Musics {
  final int id;
  final String poster;
  final String title;
  final String singer;
  final String link;
  final String singerUrl;
  final int rank;
  final int duration;

  Musics({
    required this.id,
    required this.rank,
    required this.title,
    required this.poster,
    required this.singer,
    required this.link,
    required this.duration,
    required this.singerUrl,
  });

  factory Musics.fromJson(Map<String, dynamic> json) {
    return Musics(
      id: json["id"],
      poster: json["album"]["cover_medium"],
      title: json["title"],
      singer: json["artist"]["name"],
      link: json["link"],
      singerUrl: json["artist"]["picture_small"],
      rank: json["rank"],
      duration: json["duration"],
    );
  }
}

class FavoriteMusic {
  final int imdbId;
  final String poster;
  final String title;
  final String video;

  FavoriteMusic({
    required this.imdbId,
    required this.title,
    required this.poster,
    required this.video,
  });

  factory FavoriteMusic.fromJson(Map<String, dynamic> json) {
    return FavoriteMusic(
        imdbId: json["id"],
        poster: json["album"],
        title: json["title"],
        video: json["video"]);
  }
}

Future<List<Musics>>? fetchAllMusics() async {
  final response = await http.get(Uri.parse("https://api.deezer.com/chart"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["tracks"]["data"];
    return list.map((music) => Musics.fromJson(music)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}

Future<List<FavoriteMusic>>? fetchMusicFavorite() async {
  final response = await http.get(
      Uri.parse("https://my-json-server.typicode.com/K0SANUCAK/musicjson/db"));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list
        .map((favoritemusic) => FavoriteMusic.fromJson(favoritemusic))
        .toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}

class MusicSearch {
  final int id;
  final String poster;
  final String title;
  final String singer;
  final String link;
  final String singerUrl;
  final int rank;
  final int duration;
  MusicSearch(
      {required this.id,
      required this.rank,
      required this.duration,
      required this.title,
      required this.poster,
      required this.singer,
      required this.link,
      required this.singerUrl});

  factory MusicSearch.fromJson(Map<String, dynamic> json) {
    return MusicSearch(
        id: json["id"],
        poster:
            json["album"]["cover_medium"] ?? json["artist"]["picture_medium"],
        title: json["title"],
        singer: json["artist"]["name"],
        link: json["link"],
        singerUrl: json["artist"]["picture_small"],
        rank: json["rank"],
        duration: json["duration"]);
  }
}

Future<List<MusicSearch>>? fetchMusicSearch(String word) async {
  final response =
      await http.get(Uri.parse("https://api.deezer.com/search?q=$word"));

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["data"];
    return list
        .map((musicsearch) => MusicSearch.fromJson(musicsearch))
        .toList();
  } else {
    throw Exception("Failed to load movies!");
  }
}
