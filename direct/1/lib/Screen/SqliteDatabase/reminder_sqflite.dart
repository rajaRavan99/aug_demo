import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../Model/reminder_model.dart';

class ReminderDBHelper {
  static const _databaseName = "reminderDB.db";
  static const _databaseVersion = 5;
  static const reminder = 'Reminder';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAddress = 'address';
  static const columnTime = 'time';
  static const columnDate = 'date';

  ReminderDBHelper._privateConstructor();
  static final ReminderDBHelper instance = ReminderDBHelper._privateConstructor();
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
    await db.execute(''' CREATE TABLE $reminder ( 
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  
    $columnName TEXT,   
    $columnAddress TEXT,   
    $columnDate TEXT,   
    $columnTime TEXT ) ''');
  }

  // custom insert using Loop
  Future<int> customInsert(List<ReminderModel> reminderModel) async {
    int res = 0;
    Database db = await instance.database;
    for (var msg in reminderModel) {
      res = await db.insert(reminder, msg.toMap());
    }
    return res;
  }

  Future<int> insert(ReminderModel reminderModel) async {
    Database db = await instance.database;
    int res = await db.insert(reminder, reminderModel.toMap());
    print('-------Data Insert------>');
    print(res);
    return res;

  }

  Future<List<ReminderModel>> getData() async {
    final db = await instance.database;
    var result = await db.rawQuery("SELECT * FROM $reminder");
    var list = result.map((e) => ReminderModel.fromMap(e)).toList();
    print("----- Data Get -----> $list");
    return list;
  }

  Future<int> update(ReminderModel reminderModel) async {
    Database db = await instance.database;
    var res = await db.update(reminder, reminderModel.toMap(),
        where: '$columnId = ?', whereArgs: [reminderModel.id]);
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    var dataDelelte =  await db.rawDelete('DELETE FROM $reminder WHERE $columnId = ?',
        [id]);
    print('-------------->');
    print(dataDelelte);
    return dataDelelte;
  }

}
