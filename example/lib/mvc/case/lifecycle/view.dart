import 'package:flutter_mvc_example/common/widget/appbar.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:生命周期
class LifecyclePage extends BasePage<LifecycleController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1f1f1),
      child: Column(children: <Widget>[
        WhiteAppBar("生命周期"),
        SizedBox(height: 40,),
        OutlineButton(onPressed: c.onEnterClick,child: Text("打开界面"),)
      ],),
    );
  }
}
