import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_ controllers/theme_controller.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(),
      body: animeDetails(context),
    );
  }

  AppBar detailsAppBar() {
    var animeController = Get.put(AnimeController());
    return AppBar(
      title: const Text('Details'),
      actions: [
        Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:
                  /* to add/remove to/from bookmarks */
                  InkWell(
                onTap: () {
                  animeController.bookmarkList.add(anime);
                  anime.isBookMark.value = !anime.isBookMark.value;
                },
                child: anime.isBookMark.value
                    ? Icon(
                        Icons.bookmark,
                        color: Colors.amber.shade700,
                        size: 30,
                      )
                    : const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
            ))
      ],
    );
  }

  Padding animeDetails(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* info group */
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Row(
              children: [
                /* image */
                Container(
                  width: 170,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: NetworkImage(anime.image), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 10),
                /* info */
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* rank */
                      Row(
                        children: [
                          const Text('Rank '),
                          Text(
                            '#${anime.ranking}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: MyTheme.primaryColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      /* title */
                      Text(
                        anime.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      /* type */
                      Row(
                        children: [
                          anime.type == 'TV'
                              ? const Icon(
                                  Icons.play_circle,
                                )
                              : const Icon(
                                  Icons.movie,
                                ),
                          const SizedBox(width: 5),
                          Text(anime.type),
                        ],
                      ),
                      const SizedBox(height: 10),
                      /* episode */
                      Visibility(
                          visible: anime.type == 'TV', child: Text('Episodes: ${anime.episodes}')),
                      const SizedBox(height: 10),
                      /* status */
                      Text(
                        anime.status,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          /* Genres list*/
          SizedBox(
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: anime.genres.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: themeController.isDarkMode.value
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        anime.genres[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 10),
          /* synopsis */
          Text(
            'Synopsis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(child: SingleChildScrollView(child: Text(anime.synopsis)))
        ],
      ),
    );
  }
}
