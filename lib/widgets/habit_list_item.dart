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
  dynamic _characteristic;
  String _viewRoute;
  String _editRoute;
  String _iconPath;
  BaseDBHelper _db;

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    switch (widget.habit.type) {
      case Habit.WORKOUT:
        _characteristic = (widget.habit as WorkOut).minutes;
        _viewRoute = WorkOut.viewRoute;
        _editRoute = WorkOut.editRoute;
        _iconPath = WorkOut.iconPath;
        _db = WorkOutDBHelper.db;
        break;
      case Habit.WAKEUP:
        _characteristic = (widget.habit as WakeUp).isSuccess;
        _viewRoute = WakeUp.viewRoute;
        _editRoute = WakeUp.editRoute;
        _iconPath = WakeUp.iconPath;
        _db = WakeUpDBHelper.db;
        break;
    }

    // return GestureDetector(
    //   onTap: () async {
    //     await Navigator.pushNamed(context, _viewRoute);
    //   },
    //   onLongPress: () {
    //     print("## LongPress");
    //   },
    //   child: Container(
    //     width: double.infinity,
    //     height: 70,
    //     margin:
    //         EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 8),
    //     padding: EdgeInsets.symmetric(horizontal: 12.0),
    //     decoration: BoxDecoration(
    //       // color: AppColor.habitColor,
    //       color: Colors.tealAccent,
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child: Row(
    //       children: [
    //         Image(image: AssetImage(_iconPath)),
    //         SizedBox(width: 10),
    //         Column(
    //           children: [
    //             Text(habit.title,
    //                 style: TextStyle(fontSize: 20, color: Colors.white)),
    //             Row(
    //               children: [
    //                 // if (habit.alarm)
    //                   Container(
    //                     width: 5,
    //                     height: 5,
    //                     color: Colors.teal,
    //                   ),
    //                 Text("오전 6 : 30"),
    //               ],
    //             )
    //           ],
    //         ),
    //         SizedBox(width: 60),
    //         Container(
    //           width: 20,
    //           height: 20,
    //           color: Colors.teal,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: .25,
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
              .getHabit(widget.habit.id, widget.habit.type)
              .changeIsDone();
          Provider.of<MainProvider>(context, listen: false)
              .updateHabit(_db, widget.habit);

          isDone = !isDone;
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
                opacity: isDone ? 0.1 : 1,
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
                                child: Text(widget.habit.title,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              Expanded(
                                flex: 17,
                                child: Row(
                                  children: [
                                    // Container(height: 20, width: 20, color: Colors.green),
                                    if (widget.habit.alarm)
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.yellow,
                                      ),
                                    SizedBox(width: 10),
                                    Text(
                                      "6:30 morning",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.yellow),
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
                      (_characteristic is String)
                          ? _characteristic
                          : _characteristic.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.yellow),
                    ),
                  ],
                ),
              ),
              if (isDone) Center(child: Icon(Icons.check, size: 100))
            ],
          ),
        ),
      ),
    );
  }
}
