import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'phonenumber_model.dart';

class DatabaseHelper {
  static const _databaseName = "phoneNumber.db";
  static const _databaseVersion = 5;
  static const table = 'phoneNumber';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnTime = 'time';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $table ( $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  $columnTitle TEXT,   $columnTime TEXT ) ''');
  }

  Future<int> insert(TaskData todo) async {
    Database db = await instance.database;
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<TaskData>> queryAllRow() async {
    final db = await instance.database;
    var result = await db.rawQuery("SELECT * FROM $table");
    var taskData = result.map((e) => TaskData.fromMap(e)).toList();
    print("----- Data Get Sql -----> $taskData");
    return taskData;
  }

  Future<int> update(TaskData todo) async {
    Database db = await instance.database;
    var res = await db.update(table, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
