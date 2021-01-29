import 'package:flutter/material.dart';
import 'package:winner_habit/helper/routes.dart';
import 'package:winner_habit/providers/main_provider.dart';
import 'package:winner_habit/screens/workout_view_screen.dart';
import 'helper/theme.dart';
import 'screens/habit_list_screen.dart';
import 'package:provider/provider.dart';

import 'screens/workout_edit_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WinnerHabit());
}

class WinnerHabit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
        title: "Winner's Habits",
        debugShowCheckedModeBanner: false,
        // initialRoute: 'Splash',
        initialRoute: '/HabitList',
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
      ),
    );
  }
}
