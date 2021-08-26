import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_frame/business/routers/i_router.dart';
import 'package:flutter_frame/business/view/web/webview_page.dart';

class WebRouter implements IRouterProvider{

  static String webViewPage = '/webview';

  @override
  void initRouter(FluroRouter router) {
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));
  }

}