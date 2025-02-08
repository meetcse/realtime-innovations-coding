import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/employee/add_employee/add_employee_details_screen_state.dart';

class AddEmployeeDetailsScreenCubit extends Cubit<AddEmployeeDetailsScreenState> {
  AddEmployeeDetailsScreenCubit() : super(const AEDSInitialState());

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _selectRoleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  TextEditingController get employeeNameController => _employeeNameController;
  TextEditingController get selectRoleController => _selectRoleController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
}
