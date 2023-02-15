import 'package:anime_list/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_ controllers/anime_controller.dart';
import '../widgets/anime_list_tile.dart';

class AllSeriesScreen extends StatelessWidget {
  const AllSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        title: const Text(
          'All TV Series',
        ),
      ),
      body: Obx(() => ListView.builder(
          itemCount: animeController.allSeriesList.length,
          itemBuilder: ((context, index) {
            return AnimeListTile(
              anime: animeController.allSeriesList[index],
              isRanking: false,
            );
          }))),
    );
  }
}
