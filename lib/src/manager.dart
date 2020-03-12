
import 'package:flutter_mvc/flutter_mvc.dart';

///mvc管理器
class MvcManager{
  List<BaseController> _list=[];
  List<BaseController> get controllers=>_list;

  ///当前正在显示的controller
  BaseController currentController;

  static MvcManager _instance;

  static MvcManager get instance{
    if(_instance==null){
      _instance=MvcManager();
    }
    return _instance;
  }

  void addController(BaseController controller){
    _list.add(controller);
  }

  void removeController(BaseController controller){
    assert(_list.contains(controller));
    _list.remove(controller);
  }
  ///活跃的
  void resume(BaseController controller){
    assert(_list.contains(controller));
    currentController=controller;
  }
}