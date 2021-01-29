import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/models/habits/base_habit.dart';

class WakeUp extends BaseHabit {

  static final String iconPath = " ";

  bool isSuccess;

  WakeUp({
    int id,
    String title,
    int alarmTime,
    String alarmMusic,
    String alarmHaptic,
    List repeat,
    String memo,
    bool isDone,
    Challenge whichChallenge,
    this.isSuccess,
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
          type: Habit.WAKEUP,
        );
}
