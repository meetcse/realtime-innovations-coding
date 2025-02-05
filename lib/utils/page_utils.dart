import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageUtils {
  static const PageTransitionType _pageTransitionType = PageTransitionType.rightToLeft;
  static const Duration _transitionDuration = Duration(milliseconds: 200);

  static PageTransition<void> customPageTransition(Widget pageName, {RouteSettings? settings}) {
    return PageTransition<void>(
      child: pageName,
      type: _pageTransitionType,
      duration: _transitionDuration,
      settings: RouteSettings(name: settings!.name.toString()),
    );
  }

  static Future<dynamic> pushNamed(BuildContext context, String pageName, {Map<String, dynamic>? arguments}) {
    _goingToRouteLog(pageName.toString());

    return Navigator.of(context).pushNamed(pageName, arguments: arguments);
  }

  static void pushPageNamedAndRemoveAllRoutes(BuildContext context, String pageName,
      {Map<String, dynamic>? arguments}) {
    _goingToRouteLog(pageName.toString());

    Navigator.of(context).pushNamedAndRemoveUntil(
      pageName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pushReplacementNamed(BuildContext context, String pageName, {Map<String, dynamic>? arguments}) {
    _goingToRouteLog(pageName.toString());

    Navigator.of(context).pushReplacementNamed(
      pageName,
      arguments: arguments,
    );
  }

  static void popUntilRoute(BuildContext context, String pageName) {
    // _goingToRouteLog(pageName.toString());

    // _setCurrentScreenAnalytics(pageName.toString());

    Navigator.of(context).popUntil(
      ModalRoute.withName(pageName),
    );
  }

  static void popRoute(BuildContext context, {dynamic result}) {
    log("POPPING ROUTE");
    Navigator.of(context).pop(result);
  }

  static void _goingToRouteLog(String pageName) {
    log("Going to Route " + pageName.toString());
  }
}
