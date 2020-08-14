import 'package:flutter_mvc_example/mvc/case/animation/controller.dart';
import 'package:flutter_mvc_example/mvc/case/widget/controller.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

import 'lifecycle/controller.dart';

///description:主页
class CasePage extends BasePage<CaseController> {
  var fragments = [
    WidgetController(),
    LifecycleController(),
    AnimationDemoController()
  ];

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
          Container(
            height: 60,
            child: Stateful(
                bind: () => [c.pageIndex],
                builder: (context) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                              onPressed: () {
                                c.setPage(0);
                              },
                              child: Text(
                                "组件介绍",
                                style: TextStyle(
                                    fontSize: c.pageIndex == 0?18:15,
                                    color: c.pageIndex == 0
                                        ? Color(0xff000000)
                                        : Color(0xff999999)),
                              ))),
                      Expanded(
                          child: FlatButton(
                              onPressed: () {
                                c.setPage(1);
                              },
                              child: Text(
                                "生命周期",
                                style: TextStyle(
                                    fontSize: c.pageIndex == 1?18:15,
                                    color: c.pageIndex == 1
                                        ? Color(0xff000000)
                                        : Color(0xff999999)),
                              ))),
                      Expanded(
                          child: FlatButton(
                              onPressed: () {
                                c.setPage(2);
                              },
                              child: Text(
                                "动画",
                                style: TextStyle(
                                    fontSize: c.pageIndex == 2?18:15,
                                    color: c.pageIndex == 2
                                        ? Color(0xff000000)
                                        : Color(0xff999999)),
                              ))),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
