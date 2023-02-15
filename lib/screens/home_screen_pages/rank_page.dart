import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_ controllers/anime_controller.dart';
import '../../widgets/anime_list_tile.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Obx(() => animeController.isRankLoading.value
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
        :
        /* anime list by rank */
        Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    itemCount: animeController.rankListCount.value,
                    itemBuilder: ((context, index) {
                      return index == animeController.rankListCount.value - 1
                          ?
                          /* btn for adding 10 to length */
                          TextButton(
                              onPressed: () {
                                animeController.rankListCount.value += 10;
                              },
                              child: const Text('See more'))
                          : AnimeListTile(
                              anime: animeController.rankList[index],
                              isRanking: true,
                            );
                    })),
              ),
            ],
          ));
  }
}
