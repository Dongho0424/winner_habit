import 'package:winner_habit/models/challenge.dart';

enum Habit{
  WORKOUT,
  WAKEUP,
}

class BaseHabit {
  int id;
  String title;
  bool alarm;
  int alarmTime;
  String alarmMusic;
  String alarmHaptic;
  List repeat;
  String memo;
  bool isDone;
  final Challenge whichChallenge;
  final Habit type;

  BaseHabit({
    this.id,
    this.title,
    this.alarm,
    this.alarmTime,
    this.alarmMusic,
    this.alarmHaptic,
    this.repeat,
    this.memo,
    this.isDone,
    this.whichChallenge,
    this.type,
  });

  void changeIsDone(){
    isDone = !isDone;
  }
}

