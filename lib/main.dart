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

    int _selectedIndex = 0;

    final List<BottomNavigationBarItem> _items = [
      BottomNavigationBarItem(
        label: "Home",
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: "Search",
        icon: Icon(Icons.search),
      ),
      BottomNavigationBarItem(
        label: "Statistics",
        icon: Icon(Icons.stacked_bar_chart),
      ),
      BottomNavigationBarItem(
        label: "Info",
        icon: Icon(Icons.perm_identity_sharp),
      ),
    ];


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
        title: "Winner's Habits",
        debugShowCheckedModeBanner: false,
        // initialRoute: 'Splash',
        // initialRoute: '/HabitList',
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.bottomNavigationColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            currentIndex: _selectedIndex,
            items: _items,
            onTap: (int index) {
              switch(index){
                case 0:
                  Navigator.pushNamed(context, '/HabitList');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/ChallengeSearch');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/Statistics');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/Info');
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.stacked_bar_chart),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_identity_sharp),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.bottomNavigationColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        currentIndex: _selectedIndex,
        onTap: (int index) {},
        items: _items,
      ),
    );
  }
}
