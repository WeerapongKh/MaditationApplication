import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maditation/themes.dart';
import 'package:maditation/utils/user_preferences.dart';

AppBar buildAppbar(BuildContext context) {
  final user = UserPreferences.getUser();
  final isDarkMode = user.isDarkMode;
  // ignore: prefer_const_declarations
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);
            final newUser = user.copy(isDarkMode: !isDarkMode);
            UserPreferences.setUser(newUser);
          },
        ),
      ),
    ],
  );
}
