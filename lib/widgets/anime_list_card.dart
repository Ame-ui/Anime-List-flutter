import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_ controllers/theme_controller.dart';
import '../models/anime.dart';

class AnimeListCard extends StatelessWidget {
  const AnimeListCard({super.key, required this.anime});
  final Anime anime;

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    var themeController = Get.put(ThemeController());

    return Obx(() => InkWell(
          onTap: () {
            Get.toNamed(Routes.details, arguments: anime);
          },
          /* card */
          child: Container(
            width: 170,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: themeController.isDarkMode.value ? Colors.black54 : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      color: themeController.isDarkMode.value ? Colors.black12 : Colors.grey,
                      blurRadius: 1,
                      offset: const Offset(1, 1))
                ]),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: const Alignment(1, -1),
                    children: [
                      /* image */
                      Container(
                        width: 170,
                        height: 200,
                        decoration: BoxDecoration(
                          image:
                              DecorationImage(image: NetworkImage(anime.image), fit: BoxFit.cover),
                        ),
                      ),
                      /* bookmark icon */
                      InkWell(
                        onTap: () {
                          animeController.bookmarkList.add(anime);
                          anime.isBookMark.value = !anime.isBookMark.value;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: anime.isBookMark.value
                              ? Icon(
                                  Icons.bookmark,
                                  color: Colors.amber.shade700,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.bookmark_border,
                                  size: 30,
                                ),
                        ),
                      )
                    ],
                  ),
                  /* title */
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Text(anime.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                  ),
                  /* dont show if type is not TV */
                  anime.type == 'TV'
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('Episodes: ${anime.episodes}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ));
  }
}
