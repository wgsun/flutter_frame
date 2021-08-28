import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WechatAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WechatAccountPageState();
}

class WechatAccountPageState extends State<WechatAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('公众号'),
      ),
    );
  }
}