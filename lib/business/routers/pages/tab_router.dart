import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_frame/business/routers/i_router.dart';
import 'package:flutter_frame/business/view/tab/tab_navigator.dart';

class TabRouter extends IRouterProvider {
  static String tabPage = "/tab";

  @override
  void initRouter(FluroRouter router) {
    ///tab主页
    router.define(tabPage,
        handler: Handler(handlerFunc: (_, __) => TabNavigator()));
  }
}
