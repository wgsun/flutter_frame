import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frame/common/http/http_utils.dart';
import 'package:flutter_frame/common/utils/device_utils.dart';
import 'package:flutter_frame/constants/constant.dart';


class Global {

  ///初始化全局信息
  static Future init() async {
    /// 确保初始化完成
    WidgetsFlutterBinding.ensureInitialized();

    /// sp初始化
    await SpUtil.getInstance();

    HttpUtils.init(baseUrl: Constant.baseUrl);

    LogUtil.init();

    /// 强制竖屏Pat
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // 透明状态栏
    if (Device.isAndroid) {
      const SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}