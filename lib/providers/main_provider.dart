import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MainProvider with ChangeNotifier {
  List _habitList = [];

  List get habitList => _habitList;

  dynamic getHabit(int id, String habitType) {
    return _habitList.firstWhere(
        (habit) => habit.id == id && habit.type == habitType,
        orElse: () => null);
  }

  Future create<T>(dynamic db, T habit) async {
    _habitList.insert(0, habit);

    notifyListeners();

    // db.insert()
  }

  Future update<T>(dynamic db, T habit) async {

  }
}
