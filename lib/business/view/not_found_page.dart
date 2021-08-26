import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/widgets/my_app_bar.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: Center(
        child: Text('页面不存在'),
      ),
    );
  }
}
