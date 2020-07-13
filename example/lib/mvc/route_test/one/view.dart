import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:第一个界面
class RouteOnePage extends BasePage<RouteOneController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(title: Text("第一个界面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("${c.text}这是第一个界面"),
            OutlineButton(onPressed: c.onPushClick,child: Text("打开第二个界面"),)
          ],
        ),
      ),
    );
  }
}