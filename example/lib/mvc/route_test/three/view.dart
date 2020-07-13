import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:第三个界面
class RouteThreePage extends BasePage<RouteThreeController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(title: Text("第三个界面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("这是第三个界面"),
            OutlineButton(onPressed: c.onPop2Click,child: Text("关闭第二个界面"),)
          ],
        ),
      ),
    );
  }
}