import 'package:anime_list/routes/routes.dart';
import 'package:anime_list/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MyTheme.lightThemeData,
      darkTheme: MyTheme.darkThemeData,
      themeMode: ThemeMode.system,
      getPages: Routes.getRoutes,
      initialRoute: Routes.getInitialRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}
