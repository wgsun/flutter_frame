import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frame/res/colours.dart';
import 'package:flutter_frame/res/gaps.dart';
import 'package:flutter_frame/widgets/theme_utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.titleColor,
      this.actionName = '',
      this.backImg = 'assets/images/other/ic_back_white.png',
      this.onPressed,
      this.onSearchPressed,
      this.isWhiteBack = true,
      this.isBack = true})
      : super(key: key);

  final Color backgroundColor;
  final Color titleColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final VoidCallback onSearchPressed;
  final bool isBack;
  final bool isWhiteBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    Color _titleColor;
    if (backgroundColor == null) {
      _backgroundColor = Colours.app_main;
    } else {
      _backgroundColor = backgroundColor;
    }

    ///标题颜色
    if (titleColor == null) {
      _titleColor = Colours.color_FFFFFF;
    } else {
      _titleColor = titleColor;
    }
    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    Widget back = isBack
        ? IconButton(
            onPressed: () {
              print('onPressed');
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.maybePop(context);
            },
            tooltip: 'Back',
            padding: EdgeInsets.all(ScreenUtil.getInstance().getWidth(20)),
            icon: isWhiteBack
                ? Image.asset(
                    backImg,
                    color: ThemeUtils.getIconColor(context),
                  )
                : Image.asset(
                    backImg,
                    color: Colours.color_181818,
                  ),
          )
        : Gaps.empty;

    Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: FlatButton(
                child: Text(actionName, key: const Key('actionName')),
                textColor: ThemeUtils.isDark(context)
                    ? Colours.dark_text
                    : Colours.text,
                highlightColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;

    ///搜索
    Widget search = Positioned(
        right: 0.0,
        child: onSearchPressed != null
            ? IconButton(
                onPressed: onSearchPressed,
                tooltip: 'Search',
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().getWidth(20)),
                icon: Image.asset(
                  'assets/images/other/ic_search.png',
                  width: ScreenUtil.getInstance().getWidth(50),
                  height: ScreenUtil.getInstance().getWidth(50),
                ))
            : Gaps.empty);

    Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getSp(36), color: _titleColor),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
              search,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(ScreenUtil.getInstance().getWidth(91));
}
