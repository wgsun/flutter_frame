import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/business/routers/routers.dart';
import 'package:flutter_frame/business/view/splash_page.dart';
import 'package:flutter_frame/constants/constant.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';
import 'common/global.dart';
import 'generated/l10n.dart';

void main() async {
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key) {
    Routers.initRouters();
  }

  @override
  Widget build(BuildContext context) {
    setDesignWHD(720, 1280);

    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: MaterialApp(
        ///去掉右上角debug
        debugShowCheckedModeBanner: false,
        ///导航键
        navigatorKey: Global.navigatorKey,
        ///生成路由
        onGenerateRoute: Routers.router.generator,
        ///主页
        home: SplashPage(),
        ///本地化委托
        localizationsDelegates: [
          S.delegate,
          RefreshLocalizations.delegate, //下拉刷新
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        ///支持语言
        supportedLocales: S.delegate.supportedLocales,

        ///监听当前的语言设置改变
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          Constant.countryCode = deviceLocale.countryCode;
          print("当前国家的countryCode：${deviceLocale.countryCode}");
          SpUtil.putString(Constant.locale, deviceLocale.countryCode);
          return deviceLocale;
        },
        title: 'Flutter Frame',
        ///主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
