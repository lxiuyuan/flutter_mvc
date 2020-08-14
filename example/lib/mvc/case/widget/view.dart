import 'package:flutter_mvc_example/common/widget/appbar.dart';
import 'package:flutter_mvc_example/mvc/case/widget/widget.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:组件介绍
class WidgetPage extends BasePage<WidgetController> {
  @override
  Widget build(BuildContext context) {
    print("WidgetPage:Build");
    return Container(
      color: Color(0xfff1f1f1),
      child: Column(
        children: <Widget>[
          WhiteAppBar("基础组件使用",visibleLeftButton: false,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 20,left: 2, bottom: 20),
                      child: Center(
                        child: Text(
                          "效果对比print打印",
                          style: TextStyle(inherit: false,color: Color(0xffff1111),fontSize: 19),
                        ),
                      )),

                  ///stateful的用法
                  Group(
                      Stateful(
                          bind: () => [c.statefulIndex],
                          builder: (context) {
                            print("Stateful:Build");
                            return MText("Stateful:${c.statefulIndex}");
                          }),
                      OutlineButton(
                        onPressed: c.onStatefulClick,
                        child: Text("变化"),
                      )),
                  MvcStateless(),
                  MvcStatefulWidget(),
                  SizedBox(height: 12,),
                  Group(MText("硬性全局刷新(setRootState)"),  OutlineButton(
                    color: Colors.white,
                    onPressed: c.onRootStateClick,
                    child: Text("刷新"),
                  ),),

                  Group(MText("没有变化全局刷新(setState)"), OutlineButton(
                    color: Colors.white,
                    onPressed: c.onStateClick,
                    child: Text("刷新"),
                  ),),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
