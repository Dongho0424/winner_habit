import 'package:flutter/material.dart';

class HabitColor {
  static final Color wakeUp = Colors.yellow[600];
  static final Color workOut = Colors.red[400];
}

class AppColor {
  static final Color backgroundColor = Colors.black87;
  static final Color habitColor = Colors.grey[850];
  static final Color bottomNavigationColor = Colors.grey[850];
  static final Color dDayColor = Colors.red;
}

class AppTheme {
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(color: AppColor.backgroundColor),
    backgroundColor: AppColor.backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.bottomNavigationColor),
  );
}
