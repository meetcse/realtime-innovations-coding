import 'dart:developer';

import 'package:realtime_innovations_coding/models/employee_model.dart';
import 'package:realtime_innovations_coding/services/db_services/db_helper/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeDbServices {
  final String _employeeTableName = "employee";

  Future<void> createDb(Database db) async {
    await db.execute(
      """
        CREATE TABLE IF NOT EXISTS $_employeeTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          role TEXT,
          startDate TEXT,
          endDate TEXT
        )
      """,
    );
  }

  Future<int> insertEmployees(EmployeeModel employee) async {
    int result = 0;
    try {
      Database? dbClient = await DatabaseHelper.getDatabase();

      if (dbClient != null) {
        result = await dbClient.insert(_employeeTableName, employee.toJson());
      }
      return result;
    } catch (error) {
      log("Error in insertEmployees : " + error.toString());
    }
    return result;
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    int result = 0;

    try {
      Database? dbClient = await DatabaseHelper.getDatabase();
      if (dbClient != null) {
        result = await dbClient.update(
          _employeeTableName,
          employee.toJson(),
          where: "id = ?",
          whereArgs: [employee.id],
        );
      }
    } catch (error) {
      log("Error in update employess : " + error.toString());
    }

    return result;
  }

  Future<List<EmployeeModel>> fetchAllEmployees() async {
    List<EmployeeModel> employees = [];
    try {
      Database? dbClient = await DatabaseHelper.getDatabase();
      List<Map<String, Object?>> queryResult = [];

      if (dbClient != null) {
        queryResult = await dbClient.query(_employeeTableName);

        if (queryResult.isNotEmpty) {
          for (var data in queryResult) {
            employees.add(EmployeeModel.fromJson(data));
          }
        }
      }
    } catch (error) {
      log("Error in fetch all employess : " + error.toString());
    }

    return employees;
  }
}
