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
  List _habitList = [];

  String _currentDate;

  Challenge _currentChallenge;
  List<BaseDBHelper> _currentDbList;

  List get habitList => _habitList;
  Challenge get currentChallenge => _currentChallenge;
  List<BaseDBHelper> get currentDbList => _currentDbList;

  dynamic getHabit(int id, String habitType) {
    return _habitList.firstWhere(
        (habit) => habit.id == id && habit.type == habitType,
        orElse: () => null);
  }

  // 특정 날짜(id)에 대해, 현재 챌린지에 대한 모든 db에서 habit 긁어서 habitList에 저장
  Future getAllHabitsFromDB(int id) async {
    print("## getAllHabitsFromDB");
    if(_currentChallenge != null){
      for (BaseDBHelper db in _currentDbList) {
        _habitList.add(await db.get(id));
      }
    }
    // notifyListeners();
  }

  Future createHabit(dynamic db, BaseHabit habit) async {
    _habitList.insert(0, habit);

    notifyListeners();

    await db.insert(habit);
  }

  Future updateHabit(dynamic db, BaseHabit habit) async {
    _habitList[_habitList.indexWhere((h) => h.id == habit.id && h.type == habit.type)] = habit;

    notifyListeners();

    await db.insert(habit);
  }


  // habitList도 비우고, 현재 챌린지에 대한 모든 db에서 오늘날짜에 대한 db들 삭제
  // used in createNewChallenge
  Future deleteNowHabits() async {

    _habitList.clear();

    int id = getNowId();

    // switch (_currentChallenge){
    //   case Challenge.BILLGATES:
    //     for (BaseDBHelper db in BillGates.dbs)
    //       await db.delete(id);
    //     break;
    //   case Challenge.STEVEJOBS:
    //     for (BaseDBHelper db in SteveJobs.dbs)
    //       await db.delete(id);
    //     break;
    //   default:
    //     break;
    // }
    if(_currentChallenge != null){
      for (BaseDBHelper db in _currentDbList) {
        await db.delete(id);
      }
    }

    notifyListeners();
  }

  Future CreateNewChallenge(Challenge challenge) async{

    deleteNowHabits();

    _currentChallenge = challenge;

    switch (challenge){
      case Challenge.BILLGATES:

        _currentDbList = BillGates.dbs;

        for (int i=0; i<BillGates.habits.length; i++){
          await createHabit(BillGates.dbs[i], BillGates.defaultHabits[i]);
        }
        break;
      case Challenge.STEVEJOBS:

        _currentDbList = SteveJobs.dbs;

        for (int i=0; i<SteveJobs.habits.length; i++){
          await createHabit(SteveJobs.dbs[i], SteveJobs.defaultHabits[i]);
        }
        break;
    }

    notifyListeners();
  }
}
