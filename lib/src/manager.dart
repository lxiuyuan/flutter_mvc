
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///mvc管理器+管理原生的生命周期
class MvcManager extends WidgetsBindingObserver{

  MvcManager(){

    WidgetsBinding.instance.addObserver(this);
  }

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(currentController==null){
      return;
    }
    if(state==AppLifecycleState.resumed){
      BaseController.getMvcAttribute(currentController).state.onResume();
    }else if(state==AppLifecycleState.paused){
      BaseController.getMvcAttribute(currentController).state.onPause();
    }
  }


  void addController(BaseController controller){
    _list.add(controller);
  }

  void removeController(BaseController controller){
    assert(_list.contains(controller));
    _list.remove(controller);
    if(_list.length==0){
      WidgetsBinding.instance.removeObserver(this);
    }
  }
  ///活跃的
  void resume(BaseController controller){
    currentController=controller;
  }
}