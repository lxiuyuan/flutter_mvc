import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:生命周期测试
///Author:djy
///date created 2020/08/14
class LifecycleTestController extends BaseController {
   
   LifecycleTestController():super(LifecycleTestPage());
   
   @override
   void initState(){
       super.initState();
       
   }
   
}
