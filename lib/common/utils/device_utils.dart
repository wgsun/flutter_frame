import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

class Device {

  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;



  static Future<AndroidDeviceInfo> getDeviceInf() async {
    AndroidDeviceInfo androidDeviceInfo;
    if (isAndroid) {
      final DeviceInfoPlugin plugin = DeviceInfoPlugin();
      androidDeviceInfo = await plugin.androidInfo;
    }
    return androidDeviceInfo;
  }

  /// 使用前记得初始化
  static Future<int> getAndroidSdkInt() async{
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (isAndroid && deviceInfo != null) {
      return deviceInfo.version.sdkInt;
    } else {
      return -1;
    }
  }

}
