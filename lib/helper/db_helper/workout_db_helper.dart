import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:winner_habit/models/habits/wakeup.dart';

class WorkOutDBHelper {
  WorkOutDBHelper._();

  static final WorkOutDBHelper db = WorkOutDBHelper._();

  Database _db;

  Future<Database> get database async {
    if (_db == null) {
      _db = await init();
    }

    return _db;
  }

  Future<Database> init() async {
    final String databasePath = await getDatabasesPath();

    Database db = await openDatabase(
      join(databasePath, 'work_out_database.db'),
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute("CREATE TABLE IF NOT EXISTS workout ("
            "id INTEGER PRIMARY KEY,"
            "isDone TEXT,"
            "challenge TEXT,"
            "isSuccess TEXT"
            ")");
      },
    );
    return db;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final Database db = await database;
    var temp = await db.query('workout');
    var list = temp.isNotEmpty ? temp : [];
    return list;
  }

  Future insert(Map<String, Object> data) async {
    final Database db = await database;

    db.insert("workout", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future delete(int id) async{
    final Database db = await database;

    db.delete("workout", where: 'id = ?', whereArgs: [id]);
  }
}
