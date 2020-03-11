import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:第二个界面
class TwoPage extends BasePage<TwoController>{
   
   @override
   Widget build(BuildContext context){
     print("TwoPage Build");
     return Scaffold(
       appBar: AppBar(
         title: Text("${c.title}"),
       ),
       body: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Stateful(bind: ()=>[c.alpha],builder: (ctx){
               return Opacity(opacity:c.alpha,child: Text("alpha anim"));
             },),
             FlatButton(onPressed: c.onAnimationClick, child: Text("animation"))
           ],
         ),
       ),
     );
   }
}
