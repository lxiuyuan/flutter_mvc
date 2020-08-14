import 'package:flutter_mvc_example/common/utils/toast.dart';
import 'package:flutter_mvc_example/mvc/case/lifecycle/test/controller.dart';

import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:生命周期
///Author:djy
///date created 2020/08/14
class LifecycleController extends BaseController {
   
   LifecycleController():super(LifecyclePage());
   
   @override
   void initState(){
       super.initState();
   }


   @override
   void onResume() {
     super.onResume();
    T.show(context,"生命周期:onResume");
   }

   @override
   void onPause() {
     super.onPause();
     T.show(MvcManager.instance.currentController.context,"生命周期:onPause");
   }

   @override
   void dispose() {
     super.dispose();
//     T.show(MvcManager.instance.currentController.context,"生命周期:dispose");
   }
   

  void onEnterClick() {
     LifecycleTestController().push(context);
  }
}
