import 'package:flutter_mvc_example/mvc/route_test/two/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:第三个界面
///Author:djy
///date created 2020/07/13
class RouteThreeController extends BaseController {
  final RouteTwoController routeTwoController;
   RouteThreeController(this.routeTwoController):super(RouteThreePage());
   
   @override
   void initState(){
       super.initState();
   }
   

  void onPop2Click() {
//    routeTwoController.push(context);
    routeTwoController.pop("第二个界面被第三个界面关闭");
  }
}
