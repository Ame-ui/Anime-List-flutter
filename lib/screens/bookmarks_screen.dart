import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/themes/my_theme.dart';
import 'package:anime_list/widgets/anime_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Obx(() => ListView.builder(
          itemCount: animeController.bookmarkList.length,
          itemBuilder: ((context, index) {
            return AnimeListTile(
              anime: animeController.bookmarkList[index],
              isRanking: false,
            );
          }))),
    );
  }
}
