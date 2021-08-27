import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frame/common/http/http_utils.dart';
import 'package:flutter_frame/common/utils/device_utils.dart';
import 'package:flutter_frame/constants/constant.dart';

///全局变量
class Global {

  ///利用GlobalKey
  ///1.在Flutter中，利用GolbalKey利用获取到对应Widget的State对象，来获取到NavigatorState对象
  ///2.MaterialApp中包装了WidgetsApp，而WidgetsApp包装了Navigator，并且将 Navigator的key属性，然后利用这个key去获取到NavigatorState对象
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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