import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:winner_habit/helper/db_helper/all_db_helper.dart';
import 'package:winner_habit/helper/db_helper/base_db_helper.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/models/habits/wakeup.dart';
import 'package:winner_habit/models/habits/workout.dart';
import 'package:winner_habit/providers/main_provider.dart';

class HabitListItem extends StatefulWidget {
  final BaseHabit habit;

  HabitListItem(this.habit);

  @override
  _HabitListItemState createState() => _HabitListItemState();
}

class _HabitListItemState extends State<HabitListItem> {
  // BaseHabit _currentHabit;
  dynamic _characteristic;
  String _viewRoute;
  String _editRoute;
  String _iconPath;
  BaseDBHelper _db;
  Color _color;

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    switch (widget.habit?.type) {
      case Habit.WORKOUT:
        print("this habit is WorkOut!");
        print("habit.title: ${widget.habit.title??"no"}");
        // _currentHabit = (widget.habit as WorkOut);
        _characteristic = (widget.habit as WorkOut).minutes;
        _viewRoute = WorkOut.viewRoute;
        _editRoute = WorkOut.editRoute;
        _iconPath = WorkOut.iconPath;
        _color = HabitColor.workOut;
        _db = WorkOutDBHelper.db;
        break;
      case Habit.WAKEUP:
        print("this habit is WakeUp!");
        print("habit.title: ${widget.habit.title??"no"}");
        // _currentHabit = (widget.habit as WakeUp);
        _characteristic = (widget.habit as WakeUp).isSuccess;
        _viewRoute = WakeUp.viewRoute;
        _editRoute = WakeUp.editRoute;
        _iconPath = WakeUp.iconPath;
        _db = WakeUpDBHelper.db;
        _color = HabitColor.wakeUp;
        break;
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: [
        IconSlideAction(
          color: AppColor.backgroundColor,
          icon: Icons.edit,
          onTap: () async => await Navigator.pushNamed(context, _editRoute),
        )
      ],
      child: GestureDetector(
        onTap: () async => await Navigator.pushNamed(context, _viewRoute),
        onLongPress: () {
          // 진동 추가
          Provider.of<MainProvider>(context, listen: false)
              .getHabit(widget.habit?.id, widget.habit?.type)
              .changeIsDone();
          Provider.of<MainProvider>(context, listen: false)
              .updateHabit(_db, widget.habit);

          setState(() {
            isDone = !isDone;
          });
        },
        child: Container(
          width: size.width,
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: AppColor.habitColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: (isDone ?? false) ? 0.1 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Container(height: 80, width: 80, color: Colors.blueAccent),
                        Image(
                            image: AssetImage(_iconPath), width: 80, height: 80),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 31,
                                child: Text(widget.habit?.title ?? 'default value' ,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              Expanded(
                                flex: 17,
                                child: Row(
                                  children: [
                                    // Container(height: 20, width: 20, color: Colors.green),
                                    if (widget.habit?.alarm ?? false)
                                      Icon(
                                        Icons.alarm,
                                        color: _color,
                                      ),
                                    SizedBox(width: 10),
                                    Text(
                                      "6:30 morning",
                                      style: TextStyle(
                                          fontSize: 10, color: _color),
                                    ),
                                  ],
                                ),
                              ),
//                 SizedBox(height: 0.1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Container(height: 80, width: 80, color: Colors.purple),
                    Text(
                        _characteristic ?? 'default value',
                      style: TextStyle(fontSize: 20, color: _color),
                    ),
                  ],
                ),
              ),
              if (isDone ?? false) Center(child: Icon(Icons.check, size: 100, color: Colors.grey[200],))
            ],
          ),
        ),
      ),
    );
  }
}
