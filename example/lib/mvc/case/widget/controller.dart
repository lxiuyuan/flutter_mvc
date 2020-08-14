import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
///Description:组件介绍
///Author:djy
///date created 2020/08/14
class WidgetController extends BaseController {
   
   WidgetController():super(WidgetPage());

   var statefulIndex=0;
   var statelessStatefulIndex=0;
   var statefulStatefulIndex=0;

   @override
   void initState(){
       super.initState();
       
   }
   

  void onStatefulClick() {
     statefulIndex++;
     setState();
  }

  void onStatelessStatefulClick(){
    statelessStatefulIndex++;
    setState();
  }



  void onStatefulStatefulClick() {
    statefulStatefulIndex++;
    setState();
  }

  void onRootStateClick() {
     statefulIndex++;
     //不管Stateful(bing=>[])有没有改变,统统全局刷新
     setRootState();
  }

  void onStateClick() {
     //判断Stateful(bing=>[])都没有改变-全局刷新
     setState();
  }
}
