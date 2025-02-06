import 'dart:async';
import 'dart:developer';

import 'package:realtime_innovations_coding/services/db_services/employee_db_service/employee_db_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static var tag = 'DatabaseHelper';
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  //To increase the db version please increase from here .2.3.4.5....00000
  static const int _dbVersion = 1;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  static Future<Database?> getDatabase() async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  static initDb() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = "";
      path = join(databasesPath, 'employeedb.db');
      Database db = await openDatabase(path,
          version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade, onConfigure: (db) => _onConfigure(db, 0));
    } catch (e, st) {
      log("Error in initializing db : " + e.toString() + ", stacktrace : " + st.toString());
      rethrow;
    }
  }

  ///This is the function where is going to cll only when database version get updated.
  static _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      for (int versionToUpdate = oldVersion + 1; versionToUpdate <= newVersion; ++versionToUpdate) {
        //
      }
    } catch (error) {
      log("Error in onUpgrade :: " + error.toString());
    }
  }

  static _onCreate(Database db, int newVersion) async {
    // Here execute the all create table function from respective of the models.
    await Future.wait([
      EmployeeDbServices().createDb(db),
    ]);
  }

  static _onConfigure(Database db, int newVersion) async {
    //
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
