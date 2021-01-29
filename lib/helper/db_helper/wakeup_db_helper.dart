import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/helper/db_helper/base_db_helper.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/models/habits/wakeup.dart';

class WakeUpDBHelper implements BaseDBHelper {
  WakeUpDBHelper._();

  static final WakeUpDBHelper db = WakeUpDBHelper._();

  Database _db;

  Future<Database> get database async {
    if (_db == null) {
      _db = await init();
    }

    return _db;
  }

  @override
  Future<Database> init() async {
    final String databasePath = await getDatabasesPath();

    Database db = await openDatabase(
      join(databasePath, 'wake_up_database.db'),
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute("CREATE TABLE IF NOT EXISTS wakeup ("
            "id INTEGER PRIMARY KEY,"
            "isDone TEXT,"
            "whichChallenge TEXT,"
            "isSuccess TEXT"
            ")");
      },
    );
    return db;
  }
  
  Map<String, dynamic> WakeUpToMap(WakeUp wakeUp) {
    final map = Map<String, dynamic>();
    map['id'] = wakeUp.id;
    map['isDone'] = wakeUp.isDone.toString();
    map['whichChallenge'] = wakeUp.whichChallenge;
    map['isSuccess'] = wakeUp.isSuccess.toString();
    return map;
  }
  
  WakeUp WakeUpFromMap(Map map){
    WakeUp wakeUp = WakeUp(
      id: map["id"],
      isDone: map["isDone"] == 'true' ? true : false,
      whichChallenge: map['whichChallenge'],
      isSuccess: map["isSuccess"] == 'true' ? true : false,
    );

    return wakeUp;
  }

  Future<WakeUp> get(int id) async {
    final Database db = await database;
    var temp = await db.query("wakeup", where : "id = ?", whereArgs : [id]);
    return WakeUpFromMap(temp.first);
  }

  Future<List> getAll() async {
    final Database db = await database;
    var temp = await db.query('wakeup');
    var list = temp.isNotEmpty ? temp.map((wakeup) => WakeUpFromMap(wakeup)).toList() : [];
    return list;
  }

  Future insert(WakeUp wakeUp) async {
    final Database db = await database;

    db.insert("wakeup", WakeUpToMap(wakeUp), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future delete(int id) async {
    final Database db = await database;

    db.delete("wakeup", where: 'id = ?', whereArgs: [id]);
  }
}
