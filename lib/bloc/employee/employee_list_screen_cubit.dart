import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_state.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';

class EmployeeListScreenCubit extends Cubit<EmployeeListScreenState> {
  EmployeeListScreenCubit() : super(const ELSInitialState());

  List<EmployeeModel> _employeesList = [];

  List<EmployeeModel> get getEmployees => _employeesList;
}
