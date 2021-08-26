import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frame/common/utils/device_utils.dart';
import 'package:flutter_frame/res/colours.dart';

class ThemeUtils {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }

  static Color getIconColor(BuildContext context) {
    return isDark(context) ? Colours.color_333333 : null;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color getDialogBackgroundColor(BuildContext context) {
    return Theme.of(context).canvasColor;
  }

  static Color getStickyHeaderColor(BuildContext context) {
    return isDark(context) ? Colours.color_333333 : Colours.color_333333;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? Colours.color_333333 : Colours.color_333333;
  }

  static Color getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? Colours.color_333333 : Colors.grey[200];
  }

  /// 设置NavigationBar样式
  static void setSystemNavigationBarStyle(
      BuildContext context, ThemeMode mode) {
    /// 仅针对安卓
    if (Device.isAndroid) {
      bool _isDark = false;
      final ui.Brightness platformBrightness =
          MediaQuery.platformBrightnessOf(context);
      print(platformBrightness);
      if (mode == ThemeMode.dark ||
          (mode == ThemeMode.system &&
              platformBrightness == ui.Brightness.dark)) {
        _isDark = true;
      }
      print(_isDark);
      final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _isDark ? Colours.color_333333 : Colors.white,
        systemNavigationBarIconBrightness:
            _isDark ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
