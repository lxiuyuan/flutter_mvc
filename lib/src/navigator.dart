import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///获取当前界面的名称
class MvcNavigatorManager extends NavigatorObserver {
  String currentWidgetName = "/";
  static MvcNavigatorManager manager = MvcNavigatorManager();
  //是否开启onResume,onPause(避免官方生命周期出现bug)
  bool isPauseAndResume = false;
  List<Route<dynamic>> _historyRoute = [];
  Route<dynamic> currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> oldRoute) async {
    currentRoute=route;
    Route<dynamic> previousRoute=oldRoute;
    if(route is PopupRoute){
      return;
    }

    if(oldRoute is PopupRoute){
      if(_historyRoute.length>0) {
        previousRoute = _historyRoute.last;
      }else{
        currentRoute=null;
      }
    }

    if (previousRoute is PageRoute) {
      if (isPauseAndResume)
        _changePauseListenerByElement(
            previousRoute.subtreeContext as Element, VisitorElement());
    }
    _historyRoute.add(route);
    // _getRunType(route);
  }

  void _getRunType(Route<dynamic> route) {
    String runtimeType = "";
    Widget widget;

    if (route is PageRoute) {
      var w = route.buildPage(
          route.subtreeContext, route.animation, route.secondaryAnimation);
      widget = (w as Semantics).child;
//      didELement(route.subtreeContext);
    }
    runtimeType = widget.runtimeType.toString();
    currentWidgetName = runtimeType;
  }


  void _changeResumeListenerByElement(Element element, VisitorElement visitor) {
    if (!visitor.isRun) {
      return;
    }
    try {
      element?.visitChildren((v) {
        if (v != null) {
          if (v is StatefulElement) {
            if (v.state is OnAppLifecycleListener) {
              var bing = v.state as OnAppLifecycleListener;
              visitor.isRun = false;
              bing.onResume();
            }
          }
        }
        _changeResumeListenerByElement(v, visitor);
      });
    } catch (e) {
      print(e);
    }
  }

  void _changePauseListenerByElement(Element element, VisitorElement visitor) {
    if (!visitor.isRun) {
      return;
    }
    try {
      element?.visitChildren((v) {
        if (v != null) {
          if (v is StatefulElement) {
            if (v.state is OnAppLifecycleListener) {
              var bing = v.state as OnAppLifecycleListener;
              bing.onPause();
              //结束继续遍历
              visitor.isRun = false;
            }
          }
        }
        _changePauseListenerByElement(v, visitor);
      });
    } catch (e) {
      print(e);
    }
  }

  void popAllAndPush(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 300));
    List<Route<dynamic>> popRoute = [];
    for (int i = 1; i < _historyRoute.length - 1; i++) {
      Route<dynamic> value = _historyRoute[i];
      popRoute.add(value);
      if (value is MaterialPageRoute) {
        Navigator.of(value.subtreeContext).removeRoute(value);
      }
    }

    for (var route in popRoute) {
      if (_historyRoute.contains(route)) _historyRoute.remove(route);
    }
  }
  void pop(BuildContext context,Route<dynamic> route) async {
    Navigator.of(context).removeRoute(route);
  }

  void _changeListener(Element element, int index) {
    try {
      element?.visitChildren((v) {
        if (v != null) {
          if (v is StatefulElement) {
            if (index >= 25 && index < 35);
          }
        }
        _changeListener(v, index + 1);
      });
    } catch (e) {
      print(e);
    }
  }

  void printElement(BuildContext context) {
    var e = Navigator.of(context).context as Element;
    _changeListener(e, 0);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> oldRoute) {
    Route<dynamic> previousRoute=oldRoute;
    if(route is PopupRoute){
      return;
    }
    _historyRoute.remove(route);
    if(oldRoute is PopupRoute){
      if(_historyRoute.length>0) {
        previousRoute = _historyRoute.last;
      }else{
        currentRoute=null;
      }
    }
    currentRoute=previousRoute;


    var attr=BaseController.getMvcAttribute(MvcManager.instance.currentController);
    if(attr.route==route){
      attr.route=null;
    }
    // _getRunType(previousRoute);
    if (previousRoute is PageRoute) {

      if (isPauseAndResume)
      _changeResumeListenerByElement(
          previousRoute.subtreeContext as Element, VisitorElement());
    }
  }
}

class VisitorElement {
  bool isRun = true;
}

//typedef OnStateListener=Function(int);
mixin OnAppLifecycleListener {
  void onResume() {}

  void onPause() {}
}
