import 'package:flutter/material.dart';
import 'helper/theme.dart';
import 'screens/habit_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(WinnerHabit());
}

class WinnerHabit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme.copyWith(),
      title: "Winner's Habits",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => HabitListScreen(),
      },
    );
  }
}
