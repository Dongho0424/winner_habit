import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/models/habits/basehabit.dart';
import 'package:winner_habit/models/challenge.dart';

class MainProvider with ChangeNotifier {
  List _habitList = [];

  String _currentChallenge;

  List get habitList => _habitList;
  String get currentChallenge => _currentChallenge;

  dynamic getHabit(int id, String habitType) {
    return _habitList.firstWhere(
        (habit) => habit.id == id && habit.type == habitType,
        orElse: () => null);
  }

  // 특정 날짜(id)에 대해, 현재 챌린지에 대한 모든 db에서 habit 긁어서 habitList에 저장
  Future getHabits(int id){
    switch (_currentChallenge){
      case 'billgates':
        BillGates.dbs.forEach((db) {

        });
    }
  }


  Future createHabit(dynamic db, BaseHabit habit) async {
    _habitList.insert(0, habit);

    notifyListeners();

    db.insert(habit);
  }

  Future updateHabit(dynamic db, BaseHabit habit) async {
    _habitList[_habitList.indexWhere((h) => h.id == habit.id && h.type == habit.type)] = habit;

    notifyListeners();

    db.insert(habit);
  }


}
