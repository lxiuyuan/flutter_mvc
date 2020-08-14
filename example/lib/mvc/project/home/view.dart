import 'package:flutter_mvc_example/common/widget/statebar.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'widget.dart';

///description:首页demo
class HomePage extends BasePage<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SystemStateBar(
      fontTheme: StateBarFontTheme.white,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Color(0xfff1f1f1),
          child: Column(
            children: <Widget>[
              HeaderWidget(),
              //筛选
              TabWidget(),
              //内容列表
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return c.childControllers[index].widget;
                  },
                  itemCount: c.childControllers.length,
                  controller: c.pageController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
