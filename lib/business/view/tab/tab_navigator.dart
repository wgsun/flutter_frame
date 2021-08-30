import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/business/view/tab/home_page.dart';
import 'package:flutter_frame/business/view/tab/my_page.dart';
import 'package:flutter_frame/business/view/tab/project_page.dart';
import 'package:flutter_frame/business/view/tab/structure_page.dart';
import 'package:flutter_frame/business/view/tab/whchat_account_page.dart';
import 'package:flutter_frame/common/utils/toast.dart';
import 'package:flutter_frame/generated/l10n.dart';
import 'package:flutter_frame/res/colours.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {

  var pages = [HomePage(), ProjectPage(), WechatAccountPage(), StructurePage(), MyPage()];

  var pageControner = PageController();
  int selectIndex = 0;
  DateTime lastPressed;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((value) =>  Toast.show("进入主页"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (lastPressed == null ||
            DateTime.now().difference(lastPressed) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          lastPressed = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: pageControner,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              selectIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text(S.of(context).tabs_home)),
            BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted),title: Text(S.of(context).tabs_project)),
            BottomNavigationBarItem(icon: Icon(Icons.group_work),title: Text(S.of(context).tabs_wechat_account)),
            BottomNavigationBarItem(icon: Icon(Icons.call_split),title: Text(S.of(context).tabs_structure)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text(S.of(context).tabs_mine)),
          ],
          currentIndex: selectIndex,
          fixedColor: Colours.app_main,
          onTap: (index) {
            pageControner.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
