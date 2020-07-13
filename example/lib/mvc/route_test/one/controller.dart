import 'package:flutter_mvc_example/mvc/route_test/two/controller.dart';
import 'package:flutter_mvc_example/mvc/two/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:第一个界面
///Author:djy
///date created 2020/07/13
class RouteOneController extends BaseController {
  var text="";

   
   RouteOneController():super(RouteOnePage());
   
   @override
   void initState(){
       super.initState();
       
   }
   

  void onPushClick() async {
     var result=await RouteTwoController().push(context);
     text=result+"，";
     setState();
  }
}
