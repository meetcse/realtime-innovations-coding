import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:realtime_innovations_coding/bloc/splash/splash_screen_state.dart';
import 'package:realtime_innovations_coding/routes/routes_name_constants.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SSInitialState());

  void init(BuildContext context) {
    _changeScreen(context);
  }

  // methods
  void _changeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    _gotoNextScreen(context, RoutesNameConstants.employeeListScreen);
  }

  void _gotoNextScreen(BuildContext context, String nextScreen) {
    PageUtils.pushPageNamedAndRemoveAllRoutes(context, nextScreen);
  }
}
