import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_coding/routes/routes.dart';
import 'package:realtime_innovations_coding/screens/splash/splash_screen.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  if (kIsWeb) {
    // Initialize FFI

    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: kIsWeb ? const Size(1000, 1000) : const Size(428, 926),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Employee',
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: const SplashScreen(),
        ),
        builder: (context, child) {
          return child!;
        });
  }
}
