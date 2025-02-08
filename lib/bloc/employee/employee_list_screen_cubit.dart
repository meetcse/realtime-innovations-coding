import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_state.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';
import 'package:realtime_innovations_coding/routes/arguments_constants.dart';
import 'package:realtime_innovations_coding/routes/routes_name_constants.dart';
import 'package:realtime_innovations_coding/services/db_services/employee_db_service/employee_db_services.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';

class EmployeeListScreenCubit extends Cubit<EmployeeListScreenState> {
  EmployeeListScreenCubit() : super(const ELSInitialState());

  final List<EmployeeModel> _currentEmployeesList = [];
  final List<EmployeeModel> _previousEmployeesList = [];

  EmployeeModel? _currentDeletingEmployeeModel;

  List<EmployeeModel> get currentEmployeesList => _currentEmployeesList;
  List<EmployeeModel> get previousEmployeesList => _previousEmployeesList;

  void initialize() {
    _fetchEmployeesData();
  }

  String getEmployeeJoiningAndEndingDate(EmployeeModel employee) {
    String date = "";

    if (employee.endDate == null || employee.endDate!.isEmpty) {
      date = AppStrings.from +
          " " +
          DateFormat("d MMM, yyyy").format(DateFormat("dd MMM yyyy").parse(employee.startDate!));

      return date;
    }

    date = DateFormat("d MMM, yyyy").format(DateFormat("dd MMM yyyy").parse(employee.startDate!)) +
        " - " +
        DateFormat("d MMM, yyyy").format(DateFormat("dd MMM yyyy").parse(employee.endDate!));

    return date;
  }

  void onFLoatingActionButtonTap(BuildContext context, {EmployeeModel? employee}) async {
    await PageUtils.pushNamed(
      context,
      RoutesNameConstants.addEmployeeDetailsScreen,
      arguments: employee != null ? {RoutesArgumentsConstants.employeeModel: employee} : null,
    );
    await _fetchEmployeesData();
  }

  Future<void> deleteEmployeeData(EmployeeModel employee) async {
    try {
      _currentDeletingEmployeeModel = employee;
      employee.isDeleted = 1;
      await EmployeeDbServices().updateEmployee(employee);

      await _fetchEmployeesData();

      emit(const ELSSShowToastState(AppStrings.employeeDataDeleted));
    } catch (error) {
      log("Error in deleting : " + error.toString());
    }
  }

  Future<void> onUndoDeletePressed() async {
    try {
      if (_currentDeletingEmployeeModel != null) {
        _currentDeletingEmployeeModel!.isDeleted = 0;
        await EmployeeDbServices().updateEmployee(_currentDeletingEmployeeModel!);

        await _fetchEmployeesData();
      }
    } catch (error) {
      log("Error in deleting : " + error.toString());
    }
  }

  Future<void> _fetchEmployeesData() async {
    try {
      // emit(const )

      var data = await Future.wait(
          [EmployeeDbServices().fetchCurrentEmployees(), EmployeeDbServices().fetchPreviousEmployees()]);

      if (data.isNotEmpty) {
        if (data[0].isNotEmpty) {
          _currentEmployeesList.clear();
          _currentEmployeesList.addAll(data[0]);
        }

        if (data[1].isNotEmpty) {
          _previousEmployeesList.clear();
          _previousEmployeesList.addAll(data[1]);
        }
      }
      log("Got current employees list : " + currentEmployeesList.toString());

      if (state is ELSEmployeeListFetchSuccessState) {
        emit(const ELSTempState());
      }
      emit(ELSEmployeeListFetchSuccessState(_currentEmployeesList));
    } catch (error) {
      log("Error in fetching employees : " + error.toString());
    }
  }
}
