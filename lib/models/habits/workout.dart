import 'package:winner_habit/helper/constants.dart';
import 'package:winner_habit/models/habits/base_habit.dart';

import '../challenge.dart';

class WorkOut extends BaseHabit {

  static final String iconPath = " ";

  String minutes;

  WorkOut({
    int id,
    String title,
    int alarmTime,
    String alarmMusic,
    String alarmHaptic,
    List<Week> repeat,
    String memo,
    bool isDone,
    Challenge whichChallenge,
    this.minutes,
  }) : super(
    id: id,
    title: title,
    alarmTime: alarmTime,
    alarmMusic: alarmMusic,
    alarmHaptic: alarmHaptic,
    repeat: repeat,
    memo: memo,
    isDone: isDone,
    whichChallenge: whichChallenge,
    type: Habit.WORKOUT,
  );

}
