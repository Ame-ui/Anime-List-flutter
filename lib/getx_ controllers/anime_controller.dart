import 'package:anime_list/services/animedb_api.dart';
import 'package:get/get.dart';

import '../models/anime.dart';

class AnimeController extends GetxController {
  var allAnimeList = <Anime>[].obs;
  var allSeriesList = <Anime>[].obs;
  var allMovieList = <Anime>[].obs;
  var isHomeLoading = true.obs;

  /* initialize all data */
  void fetchData() async {
    isHomeLoading.value = true;
    var allAnime = await AnimeDbApiService.fetchDataFromApi();
    isHomeLoading.value = false;
    if (allAnime.isNotEmpty) {
      allAnimeList.value = allAnime;
      checkingAnime();

      isRankLoading.value = true;
      sortRank();
      isRankLoading.value = false;
    }
  }

  /* split series and movie */
  void checkingAnime() async {
    for (var anime in allAnimeList) {
      if (anime.type == 'TV') {
        allSeriesList.add(anime);
      } else if (anime.type == 'Movie') {
        allMovieList.add(anime);
      }
    }
  }

  /* for rank page */
  var isRankLoading = true.obs;
  var rankListCount = 11.obs;
  var rankList = <Anime>[].obs;
  void sortRank() {
    for (var element in allAnimeList) {
      if (element.ranking != 0) {
        rankList.add(element);
      }
    }
    rankList.sort(
      (a, b) => a.ranking.compareTo(b.ranking),
    );
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  var bookmarkList = <Anime>[].obs;
}
