import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/models/habits/base_habit.dart';

abstract class BaseDBHelper{

  Future<Database> init() async {}

  Future get(int id) async {}

  Future delete(int id) async {}

}