import 'dart:convert';

import 'package:get/get.dart';

List<Anime> animeFromJson(String str) =>
    List<Anime>.from(json.decode(str)["data"].map((x) => Anime.fromJson(x)));

String animeToJson(List<Anime> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class Anime extends GetxController {
  Anime({
    required this.id,
    required this.title,
    required this.ranking,
    required this.genres,
    required this.episodes,
    required this.image,
    required this.link,
    required this.status,
    required this.synopsis,
    required this.type,
  });

  String id;
  String title;
  int ranking;
  List<String> genres;
  int episodes;
  String image;
  String link;
  String status;
  String synopsis;
  String type;
  var isBookMark = false.obs;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        id: json["_id"],
        title: json["title"],
        ranking: json["ranking"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        episodes: json["episodes"],
        image: json["image"],
        link: json["link"],
        status: json["status"],
        synopsis: json["synopsis"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "ranking": ranking,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "episodes": episodes,
        "image": image,
        "link": link,
        "status": status,
        "synopsis": synopsis,
        "type": type,
      };
}
