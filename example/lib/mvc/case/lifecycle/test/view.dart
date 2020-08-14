import 'package:flutter_mvc_example/common/widget/appbar.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:生命周期测试
class LifecycleTestPage extends BasePage<LifecycleTestController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1f1f1),
      child: Column(
        children: <Widget>[
          WhiteAppBar("打开界面")
        ],
      ),
    );
  }
}
