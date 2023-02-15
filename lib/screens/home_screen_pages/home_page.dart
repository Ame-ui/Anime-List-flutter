import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/anime_list_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Obx(() => animeController.isHomeLoading.value
        /* loading */
        ? Center(
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
        : Flex(
            direction: Axis.vertical,
            children: [
              /* Series List */
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TV Series', style: Theme.of(context).textTheme.titleLarge),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.allSeries);
                              },
                              child: const Text('See more'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            return AnimeListCard(
                              anime: animeController.allSeriesList[index],
                            );
                          })),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              /* Movie list */
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Movies', style: Theme.of(context).textTheme.titleLarge),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.allMovies);
                              },
                              child: const Text('See more'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            return AnimeListCard(
                              anime: animeController.allMovieList[index],
                            );
                          })),
                    ),
                  ],
                ),
              ),
            ],
          ));
  }
}
