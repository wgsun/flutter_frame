import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_frame/common/utils/device_utils.dart';
import 'package:flutter_frame/res/colours.dart';
import 'package:flutter_frame/res/gaps.dart';
import 'package:flutter_frame/widgets/my_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();
    if (Device.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              if (snapshot.hasData) {
                final bool canGoBack = await snapshot.data.canGoBack();
                if (canGoBack) {
                  // 网页可以返回时，优先返回上一页
                  await snapshot.data.goBack();
                  return Future.value(false);
                }
              }
              return Future.value(true);
            },
            child: Scaffold(
              appBar: MyAppBar(
                isWhiteBack: false,
                backgroundColor: Colours.color_FFFFFF,
                centerTitle: widget.title,
                titleColor: Colours.color_181818,
              ),
              body: Stack(
                children: [
                  WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    allowsInlineMediaPlayback: true,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                      setState(() {
                        _progressValue = progress;
                      });
                    },
                  ),
                  if (_progressValue != 100)
                    LinearProgressIndicator(
                      value: _progressValue / 100,
                      backgroundColor: Colors.transparent,
                      minHeight: 2,
                    )
                  else
                    Gaps.empty,
                ],
              ),
            ),
          );
        });
  }
}
