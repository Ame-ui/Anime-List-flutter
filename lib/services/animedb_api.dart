import 'package:http/http.dart' as http;

import '../models/anime.dart';
import '../models/genre.dart';

class AnimeDbApiService {
  static var client = http.Client();

  static Future<List<Anime>> fetchDataFromApi() async {
    var uri = Uri.https('anime-db.p.rapidapi.com', '/anime', {
      "page": "1",
      "size": "23965",
      "sortBy": "title",
      "sortOrder": "desc",
    });
    var response = await client.get(uri, headers: {
      "X-RapidAPI-Key": "fe15f9c563msh5ebd6aed6210a1ep1098f5jsne5704f1cd414",
      "X-RapidAPI-Host": "anime-db.p.rapidapi.com",
      "useQueryString": "true"
    });
    if (response.statusCode == 200) {
      return animeFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Genre>> fetchGenreFromApi() async {
    var url = Uri.https('anime-db.p.rapidapi.com', '/genre');
    var response = await client.get(url, headers: {
      "X-RapidAPI-Key": "fe15f9c563msh5ebd6aed6210a1ep1098f5jsne5704f1cd414",
      "X-RapidAPI-Host": "anime-db.p.rapidapi.com",
      "useQueryString": "true"
    });
    if (response.statusCode == 200) {
      return genreFromJson(response.body);
    } else {
      return [];
    }
  }
}
