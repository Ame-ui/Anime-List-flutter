import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_ controllers/genre_controller.dart';
import '../../widgets/anime_list_tile.dart';

class GenrePage extends StatelessWidget {
  const GenrePage({super.key});

  @override
  Widget build(BuildContext context) {
    var genreController = Get.put(GenreController());
    var animeController = Get.put(AnimeController());
    return Obx(() => genreController.isGenreLoading.value || animeController.isHomeLoading.value
        ?
        /* loading */
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 25),
                Text(
                  'Fetching data\nPlease wait',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        : Column(
            children: [
              /* dropdown to choose genre */
              DropdownButtonFormField(
                  decoration:
                      const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Select Genre',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    ),
                  ),
                  items: genreController.genreList
                      .map((element) =>
                          DropdownMenuItem(value: element.genre, child: Text(element.genre)))
                      .toList(),
                  onChanged: ((value) {
                    genreController.selectedGenre.value = value as String;
                    /* get anime by genre */
                    genreController.animeListByGenre.clear();
                    for (var anime in animeController.allAnimeList) {
                      if (anime.genres.contains(value)) {
                        genreController.animeListByGenre.add(anime);
                      }
                    }
                  })),
              /* list of anime by selected genre */
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    itemCount: genreController.animeListByGenre.length,
                    itemBuilder: ((context, index) {
                      return AnimeListTile(
                        anime: genreController.animeListByGenre[index],
                        isRanking: false,
                      );
                    })),
              ),
            ],
          ));
  }
}
