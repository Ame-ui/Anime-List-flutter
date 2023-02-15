import 'package:anime_list/getx_%20controllers/anime_controller.dart';
import 'package:anime_list/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/anime.dart';
import '../widgets/anime_list_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ValueNotifier<List<Anime>> searchList = ValueNotifier([]);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var animeController = Get.put(AnimeController());
    return Container(
      color: MyTheme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: searchAppbar(animeController),
          body: ValueListenableBuilder(
            valueListenable: searchList,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: ((context, index) {
                    return AnimeListTile(
                      anime: value[index],
                      isRanking: false,
                    );
                  }));
            },
          ),
        ),
      ),
    );
  }

  AppBar searchAppbar(AnimeController animeController) {
    return AppBar(
      title: TextField(
        onChanged: (value) {
          // debugPrint(value);
          searchList.value = List.from(searchList.value..clear());
          if (value != '') {
            for (var element in animeController.allAnimeList) {
              if (element.title.toLowerCase().contains(value.toLowerCase())) {
                searchList.value = List.from(searchList.value..add(element));
              }
            }
          }
        },
        controller: _textEditingController,
        autocorrect: false,
        autofocus: true,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            suffixIcon: IconButton(
                onPressed: () {
                  _textEditingController.text = '';
                  searchList.value = List.from(searchList.value..clear());
                },
                icon: const Icon(Icons.close))),
      ),
    );
  }
}
