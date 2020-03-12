import 'package:flutter/material.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///Description:第二个界面
///Author:djy
///date created 2020/03/10
class TwoController extends BaseController {
  static final thisName = "Two";

  TwoController() : super(TwoPage());

//   标题
  var title = "${thisName}Page";


  var alpha = 1.0;

  AnimationMvcController animationController;

  @override
  void initState() {
    super.initState();
    animationController=AnimationMvcController(value: 1,lowerBound: 0,controller: this);
    _initListener();
    print("${thisName}Controller initState()");
  }

  void _initListener() {
    animationController.addListener(() {
      alpha = animationController.value;
      print(alpha);
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

  ///click 透明度动画
  void onAnimationClick() {
  }
   
}
