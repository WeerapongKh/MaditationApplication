import 'package:flutter/material.dart';
import 'package:maditation/page/start.dart';
import 'package:maditation/themes.dart';
import 'package:maditation/utils/user_preferences.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: prefer_const_declarations
  static final String title = 'User Profile';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_declarations
    final user = UserPreferences.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
          builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Theme.of(context),
                title: title,
                home: const StartScreen(),
              )),
    );
  }
}
