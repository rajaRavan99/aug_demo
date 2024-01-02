import 'dart:async';

import 'package:firebasedemo/Screen/HomeScreen/home_screen_controller.dart';
import 'package:firebasedemo/models/msg_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabaseHelper {
  static const databaseName = "msg.db";
  static const databaseVersion = 1;
  static const table = 'msg';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnSubTitle = 'subtitle';

  SqlDatabaseHelper._privateConstructor();
  static final SqlDatabaseHelper instance = SqlDatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    print('${path}');
    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT, 
    $columnSubTitle TEXT,
    isSelected INTEGER)''');
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE msg(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,isSelected INTEGER )",
        );
      },
      version: 1,
    );
  }

  // query :-

  Future<List<MsgData>> queryAllRow() async {
    final db = await instance.database;
    var result = await db.rawQuery("SELECT * FROM $table");
    var msgList = result.map((e) => MsgData.fromMap(e)).toList();
    print("----- Data Get -----> ${msgList.length}");
    return msgList;
  }


  Future<void> deleteMsg(int id) async {
    final db = await initializeDB();
    await db.delete(
      'msg',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //Insert Data :-
  Future<int> customInsert(List<MsgData> msgData) async {
    print('================${msgData.length}');
    int res = 0;
    Database db = await instance.database;
    for(int i = 0 ; i<msgData.length ; i++){
      print('msddfdff----${msgData[i]}');
      res = await db.insert(table, msgData[i].toMap());
    }
        // for (var msg in msgData) {
        //   print('----msg--> ${msg}');
        //   res = await db.insert(table, msg.toMap());
        // }
    return res;
  }

  Future<int> insert(MsgData msgData) async {
    Database db = await instance.database;
    var res = await db.insert(table, msgData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('---------insert--------> ${res}');

    return res;
  }


  Future<int> update(MsgData msgData) async {
    Database db = await instance.database;
    var res = await db.update(table, msgData.toMap(),
        where: '$columnId = ?', whereArgs: [msgData.id]);

    print('------update--------> ${res}');
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future deleteTableAll() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
