
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/src/ele.dart';
import 'page.dart';
class ControllerInherited extends InheritedWidget{
  final BaseController controller;
  BuildContext context;
  ControllerInherited({this.controller,Widget child}):super(child:child);
  @override
  bool updateShouldNotify(ControllerInherited oldWidget) {
    context=oldWidget.context;
    return oldWidget.controller!=controller;
  }



  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ControllerInherited of(BuildContext context) {

    return context.dependOnInheritedWidgetOfExactType<ControllerInherited>();
  }

  static T ofController<T extends BaseController>(BuildContext context){
    ControllerInherited inherited=of(context);
    if(inherited==null){
      return null;
    }
    if(inherited.controller is T){
      return inherited.controller;
    }
    return ofController(inherited.context);
  }


}

///State基类 获取controller
abstract class MvcState<T extends StatefulWidget, S extends BaseController>
    extends State<T> {
  S _controller;

  S get controller {
    if (_controller == null) {
      var inherited = ControllerInherited.of(context);
      _controller = inherited.controller;
    }
    return _controller;
  }

  ///mvc框架重可以使用便携式变量c，c也仅仅只能代表controller
  S get c {
    if (_controller == null) {
      var inherited = ControllerInherited.of(context);
      _controller = inherited.controller;
    }
    return _controller;
  }
}


class MvcStatelessWidget<T extends BaseController> extends StatelessWidget {

  MvcStatelessElement element;


  T get c=>element.controller;
  T get controller=>element.controller;

  @override
  MvcStatelessElement createElement() {
    return MvcStatelessElement(this);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


//ControllerBuild 获取
class ControllerBuilder<T extends BaseController> extends MvcStatelessWidget<T> {
  final Widget Function(T controller) builder;

  ControllerBuilder({this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(c);
  }
}

///节省没必要build次数，可以有效多节约系统资源
///通过diff算法整理
class Stateful extends StatefulWidget {
  //
  final List<dynamic> Function() bind;
  final WidgetBuilder builder;

  Stateful({this.bind, @required this.builder});

  @override
  StatefulState createState() => StatefulState();
}

class StatefulState extends State<Stateful> {
  MvcAttribute mvcAttribute;
  List<dynamic> oldDiffs = [];

  @override
  void initState() {
    super.initState();
  }

  void _init() {
    var inherited = ControllerInherited.of(context);
    var controller = inherited.controller;
    mvcAttribute=BaseController.getMvcAttribute(controller);
    if (widget.bind != null) {
      oldDiffs = _listNew(widget.bind());
      mvcAttribute.listStateful.add(this);
    }
  }

  @override
  void didUpdateWidget(Stateful oldWidget) {
    if (widget.bind != null) {
      oldDiffs = _listNew(widget.bind());
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  void _refresh() {
    setState(() {});
  }

  ///判断bind是否有改变，刷新
  ///return:是否有改变
  bool setDiffState() {
    var _oldDiffs = <dynamic>[];
    _oldDiffs.addAll(oldDiffs);
    var diffs = widget.bind();
    oldDiffs = _listNew(diffs);
    if (_oldDiffs == null) {
      _refresh();
      return true;
    }
    var isDiff = _listDiff(diffs, _oldDiffs);
    if (isDiff) {
      _refresh();
      return true;
    } else {
      return false;
    }
  }

  //创建新的list集合
  List _listNew(List list) {
    for (int i = 0; i < list?.length ?? 0; i++) {
      var item = list[i];
      if (item is List) {
        List l = [];
        l.addAll(item);
        list[i] = l;
      } else if (item is Map) {
        Map m = {};
        m.addAll(item);
        list[i] = m;
      }
    }
    List newList = [];
    if (list != null) newList.addAll(list);
    return newList;
  }

  @override
  void dispose() {
    if(mvcAttribute.listStateful.contains(this)) {
      mvcAttribute.listStateful.remove(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mvcAttribute == null) {
      _init();
    }
    return widget.builder(context);
  }
}








///对比list是否一样
bool _listDiff(List newList, List oldList) {
  if (newList.length != oldList.length) {
    return true;
  }
  var diffs = newList;
  var oldDiffs = oldList;
  for (int i = 0; i < diffs.length; i++) {
    if (_diffValue(diffs[i], oldDiffs[i])) {
      return true;
    }
  }
  return false;
}

///对比map是否一样
bool _mapDiff(Map newMap, Map oldMap) {
  //判断两者数量不一致
  if (newMap.length != oldMap.length) {
    return true;
  }
  var newKey = newMap.keys;
  for (var key in newKey) {
    //判断map有新增key
    if (!oldMap.containsKey(key)) {
      return true;
    }
    if (_diffValue(newMap[key], oldMap[key])) {
      return true;
    }
    oldMap.remove(key);
  }
  //如果老的map比新的map多值
  if (oldMap.length > 0) {
    return true;
  }
  return false;
}

///对比值是否一样
bool _diffValue(dynamic newValue, dynamic oldValue) {
  if (newValue.runtimeType != oldValue.runtimeType) {
    return true;
  }
  if (newValue is List) {
    if (_listDiff(newValue, oldValue)) {
      return true;
    }
  } else if (newValue is Map) {
    if (_mapDiff(newValue, oldValue)) {
      return true;
    }
  }
  //不是list并且不是map的情况下  判断两个变量值是不是一样
  if (newValue != oldValue) {
    return true;
  }
  return false;
}


