import 'package:flutter_mvc_example/mvc/case/widget/controller.dart';
import 'package:flutter_mvc_example/mvc/one/controller.dart';
import 'package:flutter_mvc_example/mvc/one/view.dart';
import 'package:flutter_mvc_example/mvc/two/controller.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

import 'lifecycle/controller.dart';

///description:主页
class CasePage extends BasePage<CaseController> {
  var fragments = [WidgetController(),LifecycleController(), TwoController()];

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
                      child: Text("生命周期"))),
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        c.setPage(2);
                      },
                      child: Text("动画"))),
            ],
          )
        ],
      ),
    );
  }
}
