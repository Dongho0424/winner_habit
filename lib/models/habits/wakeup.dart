import 'package:winner_habit/models/habits/basehabit.dart';

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
    String whichChallenge,
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
          type: 'wake_up',
        );
}
