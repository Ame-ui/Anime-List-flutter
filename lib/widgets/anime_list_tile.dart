import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_ controllers/theme_controller.dart';

class AnimeListTile extends StatelessWidget {
  const AnimeListTile({super.key, required this.anime, required this.isRanking});
  final Anime anime;
  final bool isRanking;
  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    var themeController = Get.put(ThemeController());
    return Obx(() => InkWell(
          onTap: () {
            Get.toNamed(Routes.details, arguments: anime);
          },
          child: Stack(alignment: const Alignment(1, -1), children: [
            Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: themeController.isDarkMode.value ? Colors.black12 : Colors.grey,
                        blurRadius: 1,
                        offset: const Offset(1, 1))
                  ],
                  color: themeController.isDarkMode.value ? Colors.black54 : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* image */
                  Container(
                    width: 85,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                      image: DecorationImage(image: NetworkImage(anime.image), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 10),
                  /* info */
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* name */
                        Text(anime.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis),
                        /* type */
                        Text(anime.type, style: Theme.of(context).textTheme.bodyMedium),
                        /* episodes */
                        Visibility(
                            visible: anime.type == 'TV',
                            child: Text(
                              'Episodes: ${anime.episodes}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        /* genre */
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: anime.genres.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: themeController.isDarkMode.value
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      anime.genres[index],
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  /* rank */
                  Visibility(
                    visible: isRanking,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('#'),
                          Text(
                            anime.ranking.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*for bookmark */
            InkWell(
              onTap: () {
                animeController.bookmarkList.add(anime);
                anime.isBookMark.value = !anime.isBookMark.value;
              },
              child: anime.isBookMark.value
                  ? Icon(
                      Icons.bookmark,
                      color: Colors.amber.shade700,
                    )
                  : const Icon(
                      Icons.bookmark_border,
                      color: Colors.grey,
                    ),
            )
          ]),
        ));
  }
}
