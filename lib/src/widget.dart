import 'package:flutter/cupertino.dart';
import 'page.dart';
class ControllerInherited extends InheritedWidget{
  final BaseController controller;
  ControllerInherited({this.controller,Widget child}):super(child:child);
  @override
  bool updateShouldNotify(ControllerInherited oldWidget) {
    return oldWidget.controller!=controller;
  }

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ControllerInherited of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ControllerInherited);
  }


}