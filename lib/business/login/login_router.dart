import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_frame/business/routers/i_router.dart';

import 'login_page.dart';

class LoginRouter implements IRouterProvider {

  static String loginPage = '/login';

  @override
  void initRouter(FluroRouter router) {
    ///登录
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, __) => LoginPage()));
  }


}