class BaseHabit {
  int id;
  String title;
  int alarmTime;
  String alarmMusic;
  String alarmHaptic;
  List repeat;
  String memo;
  bool isDone;
  final String whichChallenge;
  final String type;

  BaseHabit({
    this.id,
    this.title,
    this.alarmTime,
    this.alarmMusic,
    this.alarmHaptic,
    this.repeat,
    this.memo,
    this.isDone,
    this.whichChallenge,
    this.type,
  });
}
