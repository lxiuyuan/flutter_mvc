import 'package:flutter_mvc_example/mvc/route_test/three/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:第二个界面
///Author:djy
///date created 2020/07/13
class RouteTwoController extends BaseController {
   
   RouteTwoController():super(RouteTwoPage());
   
   @override
   void initState(){
       super.initState();
       
   }
   

  void onPushClick() {
     RouteThreeController(this).push(context);
  }
}
