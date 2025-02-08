// ignore_for_file: unnecessary_null_in_if_null_operators, no_leading_underscores_for_local_identifiers

// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:realtime_innovations_coding/routes/routes_name_constants.dart';
import 'package:realtime_innovations_coding/screens/employee/add_employee/add_employee_details_screen.dart';
import 'package:realtime_innovations_coding/screens/employee/employee_list_screen.dart';
import 'package:realtime_innovations_coding/screens/splash/splash_screen.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget? _pageName;

  late Map<String, dynamic> _arguments;
  if (settings.arguments != null) {
    _arguments = settings.arguments as Map<String, dynamic>;
  } else {
    _arguments = {};
  }

  switch (settings.name) {
    case RoutesNameConstants.splashScreen:
      _pageName = const SplashScreen();

      break;
    case RoutesNameConstants.employeeListScreen:
      _pageName = const EmployeeListScreen();

      break;
    case RoutesNameConstants.addEmployeeDetailsScreen:
      _pageName = const AddEmployeeDetailsScreen();

      break;
  }
  return PageUtils.customPageTransition(_pageName!, settings: settings);
}
