import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/models/habits/wakeup.dart';
import 'package:winner_habit/models/habits/workout.dart';

class HabitList extends StatelessWidget {
  final BaseHabit habit;

  dynamic _characteristic;
  String _viewRoute;
  String _editRoute;
  String _iconPath;

  HabitList(this.habit);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    switch (habit.type) {
      case Habit.WORKOUT:
        _characteristic = (habit as WorkOut).minutes;
        _viewRoute = WorkOut.viewRoute;
        _editRoute = WorkOut.editRoute;
        _iconPath = WorkOut.iconPath;
        break;
      case Habit.WAKEUP:
        _characteristic = (habit as WakeUp).isSuccess;
        _viewRoute = WakeUp.viewRoute;
        _editRoute = WakeUp.editRoute;
        _iconPath = WakeUp.iconPath;
        break;
    }

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, _viewRoute);
      },
      onLongPress: () {
        print("## LongPress");
      },
      child: Container(
        width: double.infinity,
        height: 70,
        margin:
            EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: AppColor.habitColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image(image: AssetImage(_iconPath)),
            SizedBox(width: 10),
            Column(
              children: [
                Text(habit.title,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                Row(
                  children: [
                    if (habit.alarm)
                      Container(
                        width: 5,
                        height: 5,
                        color: Colors.teal,
                      ),
                    Text("오전 6 : 30"),
                  ],
                )
              ],
            ),
            SizedBox(width: 60),
            Container(
              width: 20,
              height: 20,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
