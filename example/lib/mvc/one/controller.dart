import 'package:flutter/animation.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///Description:第一个界面
///Author:djy
///date created 2020/03/10
class OneController extends BaseController {
  static final thisName = "One";

  OneController() : super(OnePage());

//   标题
  var title = "${thisName}Page";

//    stateless文本
  var statelessText = "StatelessWidget";

//    stateful文本
  var statefulText = "StatefulWidget";

//    文本
  var text = "text";

  var alpha = 1.0;
  var endText=0;

  @override
  void initState() {
    super.initState();
    _initListener();
    print("${thisName}Controller initState()");
  }

  void _initListener() {
    super.animationController.addListener(() {
      alpha = animationController.value;
      setState();
    });
  }

  void onResume() {
    super.onResume();
    print("${thisName}Controller onResume()");
  }

  void onPause() {
    super.onPause();
    print("${thisName}Controller onPause()");
  }

  void dispose() {
    super.dispose();
    print("${thisName}Controller dispose()");
  }

  ///click stateless改变
  void onStatelessClick() {
    statelessText = "StatelessWidget${++endText}";
    setState(() {});
  }
  ///click stateful改变
  void onStatefulClick() {
    statefulText = "StatefulWidget${++endText}";
    setState(() {});
  }
  ///click text改变
  void onTextClick() {
    text = "text${++endText}";
    setState(() {});
  }
  ///click按钮点击事件
  void onAllClick() {
    ////效果查看log输出
    setState();
  }
}
