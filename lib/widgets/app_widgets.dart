import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/utils/app_text_styles.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';

class AppWidgets {
  static bool _isDialogOpen = false;

  static Widget spacingWidget(double height, [double? width]) {
    return SizedBox(
      height: height.h,
      width: width?.w,
    );
  }

  static Widget backButton(BuildContext context, {Function? onTap, Color? color}) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            PageUtils.popRoute(context);
          }
        },
        child: Icon(
          Icons.arrow_back,
          size: 24,
          color: color,
        ),
      ),
    );
  }
  //TextField Widgets

  static Widget textFieldWithRectBorder({
    Key? key,
    String? hintText,
    String? labelText,
    TextEditingController? controller,
    Widget? prefix,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? suffixIcon,
    TextInputType? textInputType,
    bool autofocus = false,
    List<TextInputFormatter>? textInputFormatters,
    void Function(String)? onChanged,
    TextStyle? hintTextStyle,
    TextStyle? labelTextStyle,
    Color? enableBorderColor,
    Color? focusBorderColor,
    int? maxlines,
    int? minlines,
    double? enabledBorderRadius,
    double? focusedBorderRadius,
    EdgeInsets? contentPadding,
    BoxConstraints? prefixConstraints,
    BoxConstraints? suffixIconConstraints,
    double? enabledBorderWidht,
    double? focusedBorderWidht,
    TextStyle? textFieldTextStyle,
    bool? filled = true,
    Color? filledColor,
    FocusNode? focusNode,
    bool? readOnly,
  }) {
    return TextFormField(
      key: key,
      readOnly: readOnly ?? false,
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      cursorColor: AppColors.primaryBgColor,
      inputFormatters: textInputFormatters,
      style: textFieldTextStyle ?? AppTextStyles.textFieldTextStyle(),
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: maxlines ?? 1,
      minLines: minlines,
      onChanged: (value) {
        if (onChanged != null) return onChanged(value);
      },
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        // labelStyle: labelTextStyle ?? AppTextStyles.labelTextStyle(),
        hintText: hintText ?? '',
        hintStyle: hintTextStyle ?? AppTextStyles.hintTextStyle(),
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixConstraints,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        suffix: suffix,
        suffixIconConstraints: suffixIconConstraints,
        fillColor: AppColors.white,
        filled: filled,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(enabledBorderRadius ?? 8),
          borderSide: BorderSide(
            color: enableBorderColor ?? AppColors.borderColor,
            width: enabledBorderWidht ?? 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(focusedBorderRadius ?? 8),
          borderSide: BorderSide(
            color: focusBorderColor ?? AppColors.borderColor,
            width: focusedBorderWidht ?? 1,
          ),
        ),
      ),
    );
  }

  ///While Using centerChildWidget give text to empty string
  static Widget buttonWidget(
    String text, {
    void Function()? onPressed,
    double? width,
    Color? backgroundColor,
    Color? overlayColor,
    Color? textColor,
    Color? disabledButtonColor,
    Widget? icon,
    bool isBorder = false,
    Color? borderColor,
    double? borderRadius,
    double? borderWidth,
    FontWeight? fontWeight,
    double? fontSize,
    EdgeInsets? buttonPadding,
    Widget? centerChildWidget,
    bool isWidgetExceptText = false,
    Key? key,
  }) {
    return Container(
      color: Colors.transparent,
      width: width,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(overlayColor),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledButtonColor ?? AppColors.primaryBgColor.withOpacity(0.5);
              } else {
                return backgroundColor ?? AppColors.primaryBgColor;
              }
            },
          ),
          padding: MaterialStateProperty.all(
            buttonPadding ?? const EdgeInsets.symmetric(vertical: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 24),
              side: BorderSide(
                width: borderWidth ?? 1,
                color: isBorder ? borderColor ?? AppColors.primaryBgColor : Colors.transparent,
              ),
            ),
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon ?? Container(),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isWidgetExceptText
                      ? centerChildWidget ?? Container()
                      : Text(
                          text,
                          style: AppTextStyles.buttonTextStyle(
                              fontWeight: fontWeight, textColor: textColor, fontSize: fontSize),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget appBarNormalWithLeadingAndAction(
    String title, {
    double fSize = 18,
    Color fColor = AppColors.white,
    Color bgColor = AppColors.primaryBgColor,
    FontWeight fWeight = FontWeight.w500,
    List<Widget>? actions,
    Widget? leading,
    bool centertitle = false,
    double? elevation,
    double? leadingWidth,
    bool isGradientAppBar = false,
    Widget? isWidgetExceptText,
  }) {
    return AppBar(
      title: isWidgetExceptText ??
          Text(title, style: AppTextStyles.appTextStyle(color: fColor, fontSize: fSize, fontWeight: fWeight)),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth,
      centerTitle: centertitle,
      backgroundColor: bgColor,
      elevation: elevation ?? 0,
    );
  }

  static Widget imageFromAssetWidget(String imagePath,
      {BoxFit? fit, double? height, double? widht, Color? color, Key? key}) {
    return Image(
      key: key,
      image: AssetImage(imagePath),
      fit: fit,
      height: height?.h,
      width: widht?.w,
      color: color,
    );
  }

  /// if you want not to wrap or give maxline or overflow,
  /// give isInfiniteMaxLine = true
  ///
  /// Defaults to false
  static Widget textWidget(String text,
      {int? maxlines,
      TextStyle? textStyle,
      TextOverflow? overflow,
      TextAlign? textAlign,
      bool isInfiniteMaxLine = false}) {
    return Text(
      text,
      overflow: overflow ?? (isInfiniteMaxLine ? null : TextOverflow.ellipsis),
      maxLines: isInfiniteMaxLine ? null : maxlines ?? 1,
      style: textStyle ?? AppTextStyles.appTextStyle(),
      textAlign: textAlign,
    );
  }

  static Future dialogLoadingBar(BuildContext context, {String? message, bool? barrierDismissible}) {
    _isDialogOpen = true;
    Widget loadingWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[loadingView(), message != null ? Text(message) : Container()],
    );

    return showDialog<void>(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (context) {
          return loadingWidget;
        });
  }

  static Widget loadingView({double size = 60}) {
    return SpinKitSpinningLines(
      size: size,
      color: AppColors.primaryBgColor,
      // duration: Duration(seconds: 3),
    );
  }

  static void closeDialog(BuildContext context) {
    if (_isDialogOpen) {
      log("DIALOG CLOSED");
      Navigator.of(context).pop();
      // PageUtils.popRoute(context);
      _isDialogOpen = false;
    }
  }
}
