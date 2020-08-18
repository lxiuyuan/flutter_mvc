import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc_example/common/widget/tab/controller.dart';
import 'child/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:首页demo
///Author:djy
///date created 2020/08/12
class HomeController extends BaseController {
   
   HomeController():super(HomePage());

   var tabs=["男装","女装","童装","男鞋","化妆品","包包","日韩风格","袜子","科技产品","食品安全","招聘",];
   //所有列表内容
   List<HomeChildController> childControllers;
   var tabController=TabScrollController();
   var pageController=PageController();
   @override
   void initState(){
       super.initState();
       childControllers=tabs.map((e) => HomeChildController(e)).toList();
       tabController.combinationWithPage(pageController);
   }

   @override
  void onResume() {
    super.onResume();
  }

  @override
  void onPause() {
    super.onPause();
  }

   @override
  void dispose() {
    super.dispose();
  }
   
}




