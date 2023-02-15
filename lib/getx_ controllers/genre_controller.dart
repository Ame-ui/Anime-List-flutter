import 'package:get/state_manager.dart';

import '../models/genre.dart';
import '../services/animedb_api.dart';
import '../models/anime.dart';

class GenreController extends GetxController {
  var isGenreLoading = false.obs;
  var genreList = <Genre>[].obs;
  var animeListByGenre = <Anime>[].obs;
  var selectedGenre = ''.obs;

  void fetchGenres() async {
    isGenreLoading.value = true;
    var temp = await AnimeDbApiService.fetchGenreFromApi();
    isGenreLoading.value = false;

    if (temp.isNotEmpty) {
      genreList.value = temp;
    }
  }

  @override
  void onInit() {
    fetchGenres();
    super.onInit();
  }
}
