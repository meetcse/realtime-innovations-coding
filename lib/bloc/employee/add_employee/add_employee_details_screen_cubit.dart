import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations_coding/bloc/employee/add_employee/add_employee_details_screen_state.dart';
import 'package:realtime_innovations_coding/enums/role_enums.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';
import 'package:realtime_innovations_coding/services/db_services/employee_db_service/employee_db_services.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetailsScreenCubit extends Cubit<AddEmployeeDetailsScreenState> {
  AddEmployeeDetailsScreenCubit() : super(const AEDSInitialState());

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _selectRoleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final DateRangePickerController _dateRangePickerController = DateRangePickerController();

  EmployeeModel? _editEmployeeModel;

  DateTime _startDateDateTime = DateTime.now();
  DateTime? _endDateDateTime;

  TextEditingController get employeeNameController => _employeeNameController;
  TextEditingController get selectRoleController => _selectRoleController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  DateRangePickerController get dateRangePickerController => _dateRangePickerController;

  DateTime get startDateDateTime => _startDateDateTime;
  DateTime? get endDateDateTime => _endDateDateTime;

  void initialize(EmployeeModel? employeeModel) {
    _editEmployeeModel = employeeModel;
    _startDateController.text = getDateDisplayText(true);
    _endDateController.text = getDateDisplayText(false);
    if (_editEmployeeModel != null) {
      _employeeNameController.text = _editEmployeeModel!.name ?? "";
      _selectRoleController.text = _editEmployeeModel!.role ?? "";
      _startDateDateTime = DateFormat("d MMM yyyy").parse(_editEmployeeModel!.startDate!);
      if (_editEmployeeModel!.endDate != null && _editEmployeeModel!.endDate!.isNotEmpty) {
        _endDateDateTime = DateFormat("d MMM yyyy").parse(_editEmployeeModel!.endDate!);
      }

      _startDateController.text = getDateDisplayText(true);
      _endDateController.text = getDateDisplayText(false);
    }
  }

  void setSelectedRole(BuildContext context, RoleEnums role) {
    _selectRoleController.text = role.toStringValue();
    popRoute(context);
  }

  void popRoute(BuildContext context) {
    PageUtils.popRoute(context);
  }

  //! ----- date picker ----

  DateTime? getDateTimeFromStringForInitialDate(bool isStartDate) {
    DateTime? controllerDate;
    String switchControllerText = isStartDate ? _startDateController.text : _endDateController.text;
    switch (switchControllerText) {
      case AppStrings.today:
      case "":
        controllerDate = DateTime.now();
        break;
      case AppStrings.noDate:
        controllerDate = null;
        break;

      default:
        {
          if (switchControllerText.toLowerCase().contains("next")) {
            if (switchControllerText == getStartDateTomorrowDay()) {
              controllerDate = DateTime.now().add(const Duration(days: 1));
            } else if (switchControllerText == getStartDateDayAfterTomorrowDay()) {
              controllerDate = DateTime.now().add(const Duration(days: 2));
            }
          } else if (switchControllerText.toLowerCase().contains("after")) {
            controllerDate = DateTime.now().add(const Duration(days: 7));
          } else {
            controllerDate = DateFormat("d MMM yyyy").parse(switchControllerText);
          }
        }
    }

    log("Controler date : " + controllerDate.toString());
    if (isStartDate) {
      return controllerDate ?? DateTime.now();
    }
    return controllerDate;
  }

  String getDatePickerViewDate() {
    DateTime date = _dateRangePickerController.displayDate ?? DateTime.now();

    String month = DateFormat("MMMM").format(date) + " " + DateFormat("yyyy").format(date);
    return month;
  }

  void forwardDateTimeMonth() {
    if (_dateRangePickerController.forward != null) {
      _dateRangePickerController.forward!();

      emitDatePickerMonthChangeState();
    }
  }

  void backwardDateTimeMonth() {
    if (_dateRangePickerController.backward != null) {
      _dateRangePickerController.backward!();
      emitDatePickerMonthChangeState();
    }
  }

  void emitDatePickerMonthChangeState() {
    if (state is AEDSDatePickerMonthChangeState) {
      emit(const AEDSTempState());
    }
    emit(const AEDSDatePickerMonthChangeState());
  }

  bool isStartDateTodaySelected() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime toCheck = DateTime(_startDateDateTime.year, _startDateDateTime.month, _startDateDateTime.day);

    if (today == toCheck) {
      return true;
    }
    return false;
  }

  String getStartDateTomorrowDay() {
    DateTime now = DateTime.now();

    return DateFormat("EEEE").format(now.add(const Duration(days: 1)));
  }

  bool isStartDateTomorrowSelected() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime toCheck = DateTime(_startDateDateTime.year, _startDateDateTime.month, _startDateDateTime.day);

    if (tomorrow == toCheck) {
      return true;
    }
    return false;
  }

  String getStartDateDayAfterTomorrowDay() {
    DateTime now = DateTime.now();

    return DateFormat("EEEE").format(now.add(const Duration(days: 2)));
  }

  bool isStartDateDayAfterTomorrowSelected() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
    DateTime toCheck = DateTime(_startDateDateTime.year, _startDateDateTime.month, _startDateDateTime.day);

    if (dayAfterTomorrow == toCheck) {
      return true;
    }
    return false;
  }

  bool isStartDateAfterOneWeekSelected() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime afterOneWeek = today.add(const Duration(days: 7));
    DateTime toCheck = DateTime(_startDateDateTime.year, _startDateDateTime.month, _startDateDateTime.day);

    if (afterOneWeek == toCheck) {
      return true;
    }
    return false;
  }

  void setSelectedDatePickerStartDate(DateTime date, {bool isSetFromButtons = false}) {
    _startDateDateTime = date;
    // _startDateController.text = getDateDisplayText(true);
    if (isSetFromButtons) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        dateRangePickerController.selectedDate = _startDateDateTime;
      });
    }
    emitDatePickerMonthChangeState();
  }

  String getDateDisplayText(bool isStartDate) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime toCheck;
    if (isStartDate) {
      toCheck = DateTime(_startDateDateTime.year, _startDateDateTime.month, _startDateDateTime.day);
    } else {
      if (_endDateDateTime == null) {
        return AppStrings.noDate;
      }

      toCheck = DateTime(_endDateDateTime!.year, _endDateDateTime!.month, _endDateDateTime!.day);
    }

    if (toCheck == today) {
      return AppStrings.today;
    }

    return DateFormat("d MMM yyyy").format(isStartDate ? _startDateDateTime : _endDateDateTime!);
  }

  void setSelectedDatePickerEndDate(DateTime? date, {bool isSetFromButtons = false}) {
    _endDateDateTime = date;
    // _endDateController.text = getDateDisplayText(false);
    if (isSetFromButtons) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        dateRangePickerController.selectedDate = _endDateDateTime;
      });
    }
    emitDatePickerMonthChangeState();
  }

  bool isNoDateEndDateSelected() {
    if (_endDateDateTime == null) {
      return true;
    }
    return false;
  }

  bool isEndDateTodaySelected() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    if (_endDateDateTime == null) {
      return false;
    }
    DateTime toCheck = DateTime(_endDateDateTime!.year, _endDateDateTime!.month, _endDateDateTime!.day);

    if (today == toCheck) {
      return true;
    }
    return false;
  }

  void onSaveDatePickerTap(BuildContext context) {
    _startDateController.text = getDateDisplayText(true);
    _endDateController.text = getDateDisplayText(false);
    popRoute(context);
  }

  void onCancelDatePickerTap(BuildContext context) {
    //TODO: ADD FOR isEDIT

    // _startDateDateTime = DateTime.now();
    // _endDateDateTime = null;
    // _startDateController.text = getDateDisplayText(true);
    // _endDateController.text = getDateDisplayText(false);
    popRoute(context);
  }

  void setDateRangeControllerToNullOnPickerOpen(bool isStartDate) {
    _dateRangePickerController.selectedDate = getDateTimeFromStringForInitialDate(isStartDate);
  }

//! ----- date picker end ----

  void onSaveEmpoyeeDetailsTap(BuildContext context) async {
    if (_employeeNameController.text.isEmpty) {
      emit(const AEDSShowToastState(AppStrings.employeeNameNotEmpty));
      return;
    } else if (_selectRoleController.text.isEmpty) {
      emit(const AEDSShowToastState(AppStrings.roleNotEmptu));
      return;
    } else if (startDateController.text.isEmpty) {
      emit(const AEDSShowToastState(AppStrings.startDateNotEmpty));
      return;
    } else if (_endDateController.text.isNotEmpty) {
      if (_endDateDateTime != null && _startDateDateTime.isAfter(_endDateDateTime!)) {
        emit(const AEDSShowToastState(AppStrings.endDateAfterStartDate));
        return;
      }
    }

    await _storeOrUpdateEmployeeDetails();

    popRoute(context);
  }

//! ---- db calls ----

  Future<void> _storeOrUpdateEmployeeDetails() async {
    try {
      EmployeeModel employee = EmployeeModel();

      employee.name = _employeeNameController.text;
      employee.role = _selectRoleController.text;
      employee.startDate = DateFormat("d MMM yyyy").format(_startDateDateTime);
      employee.endDate = _endDateDateTime == null ? null : DateFormat("d MMM yyyy").format(_endDateDateTime!);

      if (_editEmployeeModel != null) {
        employee.id = _editEmployeeModel!.id;
        employee.isDeleted = _editEmployeeModel!.isDeleted;
        await EmployeeDbServices().updateEmployee(employee);
      } else {
        await EmployeeDbServices().insertEmployees(employee);
      }
    } catch (error) {
      log("Error in storing employees : " + error.toString());
    }
  }

//! ---- db calls end ----
}
