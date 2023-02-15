import 'package:anime_list/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_ controllers/anime_controller.dart';
import '../widgets/anime_list_tile.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        title: const Text(
          'All Movies',
        ),
      ),
      body: Obx(() => ListView.builder(
          itemCount: animeController.allMovieList.length,
          itemBuilder: ((context, index) {
            return AnimeListTile(
              anime: animeController.allMovieList[index],
              isRanking: false,
            );
          }))),
    );
  }
}
