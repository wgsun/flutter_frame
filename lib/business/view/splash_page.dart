import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/business/routers/fluro_navigator.dart';
import 'package:flutter_frame/business/routers/pages/tab_router.dart';
import 'package:flutter_frame/res/colours.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      NavigatorUtils.push(context, TabRouter.tabPage, replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          color: Colours.app_main,
        ),
      ),
    );
  }
}
