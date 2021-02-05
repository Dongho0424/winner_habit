import 'package:flutter/material.dart';
import 'package:winner_habit/screens/info.dart';
import 'package:winner_habit/screens/statistics.dart';
import 'package:winner_habit/screens/challenge_search.dart';
import 'package:winner_habit/screens/habit_list_screen.dart';
import 'package:winner_habit/screens/splash.dart';
import 'package:winner_habit/screens/workout_edit_screen.dart';
import 'package:winner_habit/screens/workout_view_screen.dart';

class Routes{

  static Route onGenerateRoute(RouteSettings settings){
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }

    switch (pathElements[1]){
      case "Splash" : return MaterialPageRoute(builder: (context) => Splash());
      case "HabitList" : return MaterialPageRoute(builder: (context) => HabitListScreen());
      case "WorkOutView" : return MaterialPageRoute(builder: (context) => WorkOutViewScreen());
      case "WorkOutEdit" : return MaterialPageRoute(builder: (context) => WorkOutEditScreen());
      case "ChallengeSearch" : return MaterialPageRoute(builder: (context) => ChallengeSearch());
      case "Statistics" : return MaterialPageRoute(builder: (context) => Statistics());
      case "Info" : return MaterialPageRoute(builder: (context) => Info());
    }
  }

  static Route onUnknownRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('${settings.name.split('/')[1]} Comming soon..'),
        ),
      ),
    );
  }
}
//
// class CustomRoute<T> extends MaterialPageRoute<T> {
//   CustomRoute({WidgetBuilder builder, RouteSettings settings})
//       : super(builder: builder, settings: settings);
// }