import 'package:anime_list/screens/all_movies_scree.dart';
import 'package:anime_list/screens/all_series_screen.dart';
import 'package:anime_list/screens/bookmarks_screen.dart';
import 'package:anime_list/screens/details_screen.dart';
import 'package:anime_list/screens/home.dart';
import 'package:anime_list/screens/search_screen.dart';
import 'package:anime_list/screens/splash_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/homeScreen';
  static const String bookmark = '/bookmarkScreen';
  static const String allSeries = '/allSeriesScreen';
  static const String allMovies = '/allMoviesScreen';
  static const String details = '/detailsScreen';
  static const String search = '/searchScreen';

  static String getInitialRoute() => splash;

  static List<GetPage> getRoutes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: bookmark, page: () => const BookmarksScreen()),
    GetPage(name: allSeries, page: () => const AllSeriesScreen()),
    GetPage(name: allMovies, page: () => const AllMoviesScreen()),
    GetPage(
        name: details,
        page: () => DetailsScreen(
              anime: Get.arguments,
            )),
    GetPage(name: search, page: () => const SearchScreen()),
  ];
}
