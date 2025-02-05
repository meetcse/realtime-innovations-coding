import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle appTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 11.sp,
        height: height,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.white,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle textFieldTextStyle({
    double? fontSize,
  }) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 16.sp,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
    );
  }

  static TextStyle titleTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color = AppColors.white, double? letterSpacing}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 26.sp,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle hintTextStyle({double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 16.sp,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? AppColors.hintTextColor,
      ),
    );
  }

  static TextStyle buttonTextStyle({Color? textColor = AppColors.white, FontWeight? fontWeight, double? fontSize}) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 14.sp,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: textColor ?? AppColors.white,
      ),
    );
  }
}
