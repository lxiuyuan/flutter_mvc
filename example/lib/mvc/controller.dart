import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///Description:主页
///Author:djy
///date created 2020/03/10
class MainController extends BaseController {
   
   MainController():super(MainPage());
   var mvcTabController=MvcTabController();
   @override
   void initState(){
       super.initState();
       
   }

   void setPage(int index){
     mvcTabController.animToPage(index);
   }
   
}
