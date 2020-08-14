import 'package:flutter_mvc_example/mvc/one/controller.dart';
import 'package:flutter_mvc_example/mvc/one/view.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:主页
class MainPage extends BasePage<MainController> {
  var fragments = [OneController(), OneController()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
              child: MvcTabView(
            controller: c.mvcTabController,
            children: fragments,
          )),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        c.setPage(0);
                      },
                      child: Text("组件介绍"))),
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        c.setPage(1);
                      },
                      child: Text("动画"))),
            ],
          )
        ],
      ),
    );
  }
}
