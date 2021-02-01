import 'package:winner_habit/helper/constants.dart';
import 'package:winner_habit/helper/db_helper/all_db_helper.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/habits/wakeup.dart';
import 'package:winner_habit/models/habits/workout.dart';

enum Challenge{
  BILLGATES,
  STEVEJOBS,
}

class BillGates{
  static final habits = ["work_out", "wake_up"];
  static final defaultHabits = [
    WorkOut(
      id: getNowId(),
      title: "BillGates' work out",
      alarmTime: 30,
      alarmMusic: " ",
      alarmHaptic: " ",
      repeat: everyDay(),
      memo: "",
      isDone: false,
      whichChallenge: Challenge.BILLGATES,
      minutes: "",
    ),
    WakeUp(
      id: getNowId(),
      title: "BillGates' wake up",
      alarmTime: 30,
      alarmMusic: " ",
      alarmHaptic: " ",
      repeat: everyWeek(),
      memo: "",
      isDone: false,
      whichChallenge: Challenge.BILLGATES,
      isSuccess: true,
    ),
  ];
  static final dbs = [WorkOutDBHelper.db, WakeUpDBHelper.db];
  static final illust = "assets/winners/billgates.png";
}

class SteveJobs{
  static final habits = ["work_out", "wake_up"];
  static final defaultHabits = [
    WorkOut(
      id: getNowId(),
      title: "SteveJobs' work out",
      alarm: true,
      alarmTime: 30,
      alarmMusic: " ",
      alarmHaptic: " ",
      repeat: everyDay(),
      memo: "",
      isDone: false,
      whichChallenge: Challenge.STEVEJOBS,
      minutes: "",
    ),
    WakeUp(
      id: getNowId(),
      title: "SteveJobs' wake up",
      alarm: true,
      alarmTime: 30,
      alarmMusic: " ",
      alarmHaptic: " ",
      repeat: everyWeek(),
      memo: "",
      isDone: false,
      whichChallenge: Challenge.STEVEJOBS,
      isSuccess: true,
    ),
  ];
  static final dbs = [WorkOutDBHelper.db, WakeUpDBHelper.db];
  static final illust = "assets/winners/stevejobs.png";
}