import 'dart:convert';

List<Genre> genreFromJson(String str) =>
    List<Genre>.from(json.decode(str).map((x) => Genre.fromJson(x)));

String genreToJson(List<Genre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Genre {
  String genre;

  Genre({required this.genre});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genre: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": genre,
      };
}
