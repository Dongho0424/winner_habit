import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/helper/db_helper/base_db_helper.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/models/habits/workout.dart';

class WorkOutDBHelper implements BaseDBHelper {
  WorkOutDBHelper._();

  static final WorkOutDBHelper db = WorkOutDBHelper._();

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

    print("# workout db: ${join(databasePath, 'work_out_database.db')}");

    Database db = await openDatabase(
      join(databasePath, 'work_out_database.db'),
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute("CREATE TABLE IF NOT EXISTS workout ("
            "id INTEGER PRIMARY KEY,"
            "isDone TEXT,"
            "whichChallenge TEXT,"
            "minutes TEXT"
            ")");
      },
    );
    return db;
  }

  Map<String, dynamic> WorkOutToMap(WorkOut workOut) {
    final map = Map<String, dynamic>();
    map['id'] = workOut.id;
    map['isDone'] = workOut.isDone.toString();
    map['whichChallenge'] = toChallengeString(workOut.whichChallenge);
    map['minutes'] = workOut.minutes;
    return map;
  }

  WorkOut WorkOutFromMap(Map map){
    WorkOut workOut = WorkOut(
      id: map["id"],
      isDone: map["isDone"] == 'true' ? true : false,
      whichChallenge: toChallenge(map['whichChallenge']),
      minutes: map["minutes"],
    );

    return workOut;
  }

  Future<WorkOut> get(int id) async {
    final Database db = await database;
    var temp = await db.query("workout", where : "id = ?", whereArgs : [id]);
    return WorkOutFromMap(temp.first);
  }

  Future<List> getAll() async {
    final Database db = await database;
    var temp = await db.query('workout');
    var list = temp.isNotEmpty ? temp.map((workOut) => WorkOutFromMap(workOut)).toList() : [];
    return list;
  }

  Future insert(BaseHabit habit) async {
    WorkOut workOut = (habit as WorkOut);
    final Database db = await database;

    db.insert("workout", WorkOutToMap(workOut), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future delete(int id) async {
    final Database db = await database;

    db.delete("workout", where: 'id = ?', whereArgs: [id]);
  }
}
