import 'package:flutter/material.dart';

///https://www.jianshu.com/p/bd6157914c2d
///利用GlobalKey
///1.在Flutter中，利用GolbalKey利用获取到对应Widget的State对象，来获取到NavigatorState对象
///2.MaterialApp中包装了WidgetsApp，而WidgetsApp包装了Navigator，并且将 Navigator的key属性，
///然后利用这个key去获取到NavigatorState对象。
class RouterGlobal {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}