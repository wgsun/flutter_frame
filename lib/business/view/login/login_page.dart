import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///登录
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('login page'),
      ),
    );
  }
}
