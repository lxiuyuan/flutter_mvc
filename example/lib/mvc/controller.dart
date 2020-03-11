import 'view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///Description:主页
///Author:djy
///date created 2020/03/10
class MainController extends BaseController {
   
   MainController():super(MainPage());
   var fragmentController=FragmentController();
   @override
   void initState(){
       super.initState();
       
   }

   void setPage(int index){
     fragmentController.animToPage(index);
   }
   
}
