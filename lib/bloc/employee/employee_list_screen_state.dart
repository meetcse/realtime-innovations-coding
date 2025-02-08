import 'package:flutter/material.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';

@immutable
abstract class EmployeeListScreenState {
  const EmployeeListScreenState();
}

class ELSInitialState extends EmployeeListScreenState {
  const ELSInitialState();
}

class ELSTempState extends EmployeeListScreenState {
  const ELSTempState();
}

class ELSShowLoaderState extends EmployeeListScreenState {
  const ELSShowLoaderState();
}

class ELSSShowToastState extends EmployeeListScreenState {
  final String message;
  const ELSSShowToastState(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return false;

    return o is ELSSShowToastState && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ELSEmployeeListFetchSuccessState extends EmployeeListScreenState {
  final List<EmployeeModel> employees;
  const ELSEmployeeListFetchSuccessState(this.employees);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return false;

    return o is ELSEmployeeListFetchSuccessState && o.employees == employees;
  }

  @override
  int get hashCode => employees.hashCode;
}
