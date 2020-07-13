import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:第二个界面
class RouteTwoPage extends BasePage<RouteTwoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(title: Text("第二个界面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("第二个界面"),
            OutlineButton(onPressed: c.onPushClick,child: Text("打开第三个界面"),)
          ],
        ),
      ),
    );
  }
}
