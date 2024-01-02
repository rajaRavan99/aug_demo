
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_demo/Model/user.dart';

class DBHelper {
  static const _databaseName = "User.db";
  static const table = "Users";

  static Future<Database> database() async  {
    final directory = await getApplicationDocumentsDirectory();
    print('------------------> ${directory.path}');
    final dbPath = await sql.getDatabasesPath();
    print('dbPath======>${dbPath}');
    return sql.openDatabase(path.join(dbPath, _databaseName),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE IF NOT EXISTS $table (id INTEGER PRIMARY KEY, name TEXT, mobile TEXT, email TEXT, address TEXT)');
      },
        // onUpgrade: onUpgrade,
        version: 1);
  }

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async{
    print('--------> Done');
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE $table ADD COLUMN age TEXT');
      await db.execute('ALTER TABLE $table ADD COLUMN gender TEXT');
    }
  }

  static Future insertData(User user) async {
    final db = await DBHelper.database();
    int id2 = await db.insert(
        table, user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('inserted2: $id2');
    // return id2;
  }

  Future<List<User>> getAllRecords() async {
    final db = await DBHelper.database();
    var result = await db.rawQuery("SELECT * FROM $table");
    var newList = result.map((e) => User.fromJson(e)).toList();
    print("----- Data Get -----> $newList");
    return newList;
  }

  static Future updateData(int id, String name, String mobile, String email, String address,
      // String age,String gender
      ) async {
    final db = await DBHelper.database();
    var newValue = await db.rawUpdate(
        'UPDATE $table SET name = "$name", mobile = "$mobile", email = "$email", address = "$address",'
            // 'age = "$age", gender = "$gender"'
            '  WHERE id = $id');
    print("------> Data Updated: $newValue");
    return newValue;
  }

  static Future deleteData(int id) async {
    final db = await DBHelper.database();
    var data = await db.rawDelete('DELETE FROM $table WHERE id = ?',
        [id]);
    print("-----> Data Deleted : ${data} ---->");
    return data;
  }

  getDbPath() async {
    print('Get Database path');
    String dataBasePath = await getDatabasesPath();
    print('Datapath --->  $dataBasePath ------->');
    final externalStoragePath = await getApplicationDocumentsDirectory();
    print('ExternalStoragePath $externalStoragePath ------->');
  }

  backUpDB () async {
    print('Backup Database');
    var status = await Permission.manageExternalStorage.status;
    if(!status.isGranted)
      {
        await Permission.manageExternalStorage.request();
      }
    var status1 = await Permission.manageExternalStorage.status;
    if(!status1.isGranted){
      await Permission.manageExternalStorage.request();
    }
    try{
      File ourDBFile = File('/data/user/0/com.example.sqflite_demo/databases/User.db');
      if(await ourDBFile.exists()){
        print('file is exists');
      } else {
        print('file is not exists');
      }
      Directory folderPathForDB = Directory('/storage/emulated/0/Download/');
      await ourDBFile.copy("/storage/emulated/0/Download/User.db");
    }catch(e){
      print('------------------------> ${e.toString()}');
    }
  }

  restoreDB() async {
      print('Restore Database');
      var status = await Permission.manageExternalStorage.status;
      if(!status.isGranted)
      {
        await Permission.manageExternalStorage.request();
      }
      var status1 = await Permission.storage.status;
      if(!status1.isGranted){
        await Permission.storage.request();
      }
      try{
        File saveDBFile = File('/storage/emulated/0/Download/User.db');
        //directory path
        await saveDBFile.copy('/data/user/0/com.example.sqflite_demo/databases/User.db');
      }catch(e)
      {
        print('-----------------> ${e.toString()} <---------');
      }
}

  deleteDB() async {
      print('Delete Database');
      Future<Database>? db = DBHelper.database();
      try{
        db = null;
        var data  = deleteDatabase('/data/user/0/com.example.sqflite_demo/databases/User.db');
        print('--DeleteResponse-----> {$data}');

      }catch(e){
        print('<----error--- ${e.toString()}');
      }

}

}