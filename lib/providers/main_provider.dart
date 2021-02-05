import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/helper/db_helper/base_db_helper.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/models/challenge.dart';

class MainProvider with ChangeNotifier {
  List<BaseHabit> _habitList = [];

  int _currentDate;

  Challenge _currentChallenge;
  List<BaseDBHelper> _currentDbList;

  List<BaseHabit> get habitList => _habitList;

  Challenge get currentChallenge => _currentChallenge;

  List<BaseDBHelper> get currentDbList => _currentDbList;

  void setCurrentDate(int value) {
    print("_currentDate: $value");
    _currentDate = value;
    notifyListeners();
  }

  BaseHabit getHabit(int id, Habit habitType) {
    return _habitList.firstWhere(
        (habit) => habit.id == id && habit.type == habitType,
        orElse: () => null);
  }

  // 특정 날짜(id)에 대해, 현재 챌린지에 대한 모든 db에서 habit 긁어서 habitList에 저장
  Future getAllHabitsFromDB(int id) async {
    print("## getAllHabitsFromDB");
    print("## _currentChallenge: $_currentChallenge");
    print("## _currentDbList: $_currentDbList");
    _habitList.clear();
    if (_currentChallenge != null) {
      for (BaseDBHelper db in _currentDbList) {
        _habitList.add(await db.get(id));
      }
    }
    print("## _habitList: $_habitList");
    notifyListeners();
  }

  Future createHabit(BaseDBHelper db, BaseHabit habit) async {
    _habitList.insert(0, habit);

    print("createHabit, habit.title: ${habit.title}");
    print("createHabit, habit.type: ${habit.type}");
    print("createHabit, habit.isDone: ${habit.isDone}");
    print("createHabit, habit.whichChallenge: ${habit.whichChallenge}");

    // notifyListeners();

    await db.insert(habit);
  }

  Future updateHabit(BaseDBHelper db, BaseHabit habit) async {
    _habitList[_habitList
        .indexWhere((h) => h.id == habit.id && h.type == habit.type)] = habit;

    notifyListeners();

    await db.insert(habit);
  }

  // habitList도 비우고, 현재 챌린지에 대한 모든 db에서 오늘날짜에 대한 db들 삭제
  // used in createNewChallenge
  Future deleteNowHabits() async {
    _habitList.clear();

    int id = getNowId();

    if (_currentChallenge != null) {
      for (BaseDBHelper db in _currentDbList) {
        await db.delete(id);
      }
    }
  }

  // ignore: non_constant_identifier_names
  Future CreateNewChallenge(Challenge challenge) async {

    await deleteNowHabits();

    _currentChallenge = challenge;

    switch (challenge) {
      case Challenge.BILLGATES:
        _currentDbList = BillGates.dbs;
        print("## in CreateNewChallenge as BillGates");
        print("_currentDbList.length: ${_currentDbList.length}");

        for (int i = 0; i < BillGates.habits.length; i++) {
          await createHabit(BillGates.dbs[i], BillGates.defaultHabits[i]);
        }
        print("habitList.length: ${habitList.length}");
        break;
      case Challenge.STEVEJOBS:
        _currentDbList = SteveJobs.dbs;

        for (int i = 0; i < SteveJobs.habits.length; i++) {
          await createHabit(SteveJobs.dbs[i], SteveJobs.defaultHabits[i]);
        }
        break;
    }

    notifyListeners();
  }
}
