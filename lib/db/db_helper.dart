import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task.dart';

class DBHelper{
  static Database? _database;
  static const version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDataBase() async{
    if(_database != null){
      return;
    }

    try{
      String _path = await getDatabasesPath() + 'tasks.db';
      _database = await openDatabase(
        _path,
        version: version,
        onCreate: (db,version){
          return db.execute(
            "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT"
          "title STRING, note TEXT, isCompleted INTEGER, date STRING"
          "startTime STRING, endTime STRING, reminder INTEGER"
          "repeat STRING, color INTEGER)",
          );
        }
      );
    } catch(e){
      log(e.toString());
    }
  }
  static Future<int?> insert(Task? task) async{
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }
}