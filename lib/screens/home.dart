import 'package:anime_list/getx_%20controllers/theme_controller.dart';
import 'package:anime_list/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/my_theme.dart';
import 'home_screen_pages/genre_page.dart';
import 'home_screen_pages/home_page.dart';
import 'home_screen_pages/rank_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ValueNotifier<int> pageIndexNoti = ValueNotifier(0);

  @override
  void dispose() {
    pageIndexNoti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: homeAppBar(context),
      endDrawer: homeDrawer(),
      body: ValueListenableBuilder(
        valueListenable: pageIndexNoti,
        builder: (context, index, child) => index == 0
            ? const HomePage()
            : index == 1
                ? const RankPage()
                : const GenrePage(),
      ),
      bottomNavigationBar: homeBottomNavigationBar(),
    );
  }

  AppBar homeAppBar(BuildContext context) {
    return AppBar(
      title: Text('Anime List',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: [
        /* search button */
        IconButton(
            splashRadius: 15,
            onPressed: () {
              Get.toNamed(Routes.search);
            },
            icon: const Icon(Icons.search)),
        /* drawer button */
        IconButton(
            splashRadius: 15,
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.menu))
      ],
    );
  }

  Container homeDrawer() {
    var themeController = Get.put(ThemeController());
    return Container(
      color: MyTheme.primaryColor,
      child: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              /* header */
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                color: MyTheme.primaryColor,
                child: Text('Anime List',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              /* bookmark */
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.bookmark);
                },
                leading: const Icon(Icons.bookmark),
                title: Text('Bookmarks', style: Theme.of(context).textTheme.titleLarge),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              /* dark mode */
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text('Dark mode', style: Theme.of(context).textTheme.titleLarge),
                trailing: Obx(
                  () => Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.isDarkMode.value = value;
                      Get.changeTheme(themeController.isDarkMode.value
                          ? MyTheme.darkThemeData
                          : MyTheme.lightThemeData);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder homeBottomNavigationBar() {
    return ValueListenableBuilder(
      valueListenable: pageIndexNoti,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          selectedFontSize: 16,
          selectedIconTheme: const IconThemeData(size: 30),
          onTap: (index) {
            pageIndexNoti.value = index;
          },
          currentIndex: pageIndexNoti.value,
          selectedItemColor: MyTheme.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.align_vertical_bottom), label: 'Rank'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Genre'),
          ],
        );
      },
    );
  }
}
