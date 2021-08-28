import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_frame/business/routers/i_router.dart';
import 'package:flutter_frame/business/routers/pages/login_router.dart';
import 'package:flutter_frame/business/routers/pages/tab_router.dart';
import 'package:flutter_frame/business/routers/pages/web_router.dart';
import 'package:flutter_frame/business/view/not_found_page.dart';

class Routers {
  static final FluroRouter router = FluroRouter();

  static final List<IRouterProvider> routerList = <IRouterProvider>[];

  static void initRouters() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      LogUtil.d("未找到目标页");
      return NotFoundPage();
    });

    routerList.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    routerList.add(WebRouter());
    routerList.add(LoginRouter());
    routerList.add(TabRouter());

    /// 初始化路由
    routerList.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
