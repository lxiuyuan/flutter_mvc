import 'package:flutter/material.dart';
import 'package:flutter_mvc_example/mvc/one/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:动画
///Author:djy
///date created 2020/08/14
class AnimationDemoController extends BaseController {
   
   AnimationDemoController():super(AnimationDemoPage());

   AnimationController animationController;
   double animationValue=1;
   @override
   void initState(){
       super.initState();
       animationController=MvcAnimationController(value: 1,controller: this);
       animationController.addListener(() {
          animationValue=animationController.value;
          setState();
       });
   }

   void onAnimationClick(){
//      animationController.reset();
      animationController.animateTo(1-animationValue,duration: Duration(milliseconds: 800),curve: Curves.fastOutSlowIn);
   }
   
}
