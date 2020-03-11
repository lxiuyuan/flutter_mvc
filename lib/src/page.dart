import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'widget.dart';
import 'toast.dart';

///State基类 获取controller
abstract class BaseState<T extends StatefulWidget, S extends BaseController>
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

//ControllerBuild 获取
class ControllerBuilder<T extends BaseController> extends StatelessWidget {
  T controller;
  final Widget Function(T controller) builder;

  ControllerBuilder({this.builder});

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      controller = ControllerInherited.of(context).controller;
    }
    return builder(controller);
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
  _StatefulState createState() => _StatefulState();
}

class _StatefulState extends State<Stateful> {
  BaseController controller;
  List<dynamic> oldDiffs = [];

  @override
  void initState() {
    super.initState();
  }

  void _init() {
    var inherited = ControllerInherited.of(context);
    controller = inherited.controller;

    if (widget.bind != null) {
      oldDiffs = _listNew(widget.bind());
      controller._addState(this);
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
    controller._removeState(state: this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      _init();
    }
    return widget.builder(context);
  }
}

//Page基类
abstract class BasePage<T extends BaseController> {
  __PageWidgetState _state;
  BaseController _controller;

  ///获取内部变量 mvc config
  static MvcConfig getMvcConfig(BasePage page){
    return page._state.mvcConfig;
  }

  Widget get widget {
    return _createWidget();
  }

  T get controller => _controller;

  ///mvc Controller变量c 便携式写法
  /// mvc中c代表controller（定义为特殊变量，m、v不属于特殊变量）
  T get c => _controller;
  LoadingController _loadingController = new LoadingController();

  BuildContext get context => _state?.context;

  ///注册state方法
  ///__PageWidgetState.initState调用
  void _registerState(__PageWidgetState state) {
    this._state = state;
    if (_controller != null) {
      _controller._registerState(state);
    }
  }

  ///
  /// 注册controller方法
  /// controller初始化调用
  void _registerController(BaseController controller) {
    this._controller = controller;
    controller._loadingController = _loadingController;
    if (_state != null) {
      controller._registerState(_state);
    }
  }

  @protected
  void setState(VoidCallback fun) {
    if (_state == null) {
      return;
    }
    if (_state.mounted) {
      _state?.setState(fun);
    }
  }

  //创建_PageWidget
  Widget _createWidget() {
    return _PageWidget(this);
  }

  @protected
  @mustCallSuper
  void initState() {}

  @protected
  @mustCallSuper
  void onResume() {}

  @protected
  @mustCallSuper
  void onPause() {}

  @protected
  @mustCallSuper
  void dispose() {}

  @protected
  Widget build(BuildContext context);
}

class _PageWidget extends StatefulWidget {
  final BasePage basePage;

  _PageWidget(this.basePage);

  @override
  __PageWidgetState createState() => __PageWidgetState();
}

class __PageWidgetState extends State<_PageWidget>
    with SingleTickerProviderStateMixin {
  BasePage basePage;

  MvcConfig mvcConfig=MvcConfig();
  @override
  void initState() {
    this.basePage = widget.basePage;
    basePage._registerState(this);
    basePage.initState();
    basePage._controller?.initState();
    super.initState();
  }

  var isStart = true;

  @override
  void deactivate() {
    isStart = !isStart;
    if (isStart) {
      onResume();
    } else {
      onPause();
    }
    super.deactivate();
  }

  void onResume() {
    basePage.onResume();
    basePage._controller?.onResume();
  }

  void onPause() {
    basePage.onPause();
    basePage._controller?.onPause();
  }

  @override
  void dispose() {
    basePage.dispose();
    basePage._controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //存储controller的共享组件
        ControllerInherited(
            controller: basePage.controller, child: basePage.build(context)),
        //加载框
        Visibility(
            child: LoadingDialog(
          controller: basePage._loadingController,
        ))
      ],
    );
  }
}

//controller路由
class BasePageRoute extends MaterialPageRoute {
  BasePageRoute({
    @required BasePageRouteBuilder build,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: (context) {
              return build(context).widget;
            },
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);
}

typedef BasePageRouteBuilder = BasePage Function(BuildContext context);
typedef RouteBuilder = Route Function(Widget widget);

const RouteBuilder _kRouteBuild = _routeBuild;

Route _routeBuild(Widget widget) {
  return MaterialPageRoute(builder: (context) {
    return widget;
  });
}

///controller基类
///里面包含了app界面的生命周期
///里面还包含了
class BaseController {
  BaseController(this.page) {
    page._registerController(this);
//    _startPage();
  }
  ///获取内部变量 mvc config
  static MvcConfig getMvcConfig(BaseController c){
    return c._state.mvcConfig;
  }


  __PageWidgetState _state;
  BasePage page;
  Widget get widget=>page.widget;

  AnimationController _animationController;

  AnimationController get animationController {
    if (_animationController == null) {
      _animationController = AnimationController(vsync: _state);
    }
    return _animationController;
  }

  ///菊花圈控制器
  LoadingController _loadingController;

  BuildContext get context => _state?.context;

  List<_StatefulState> _listState = [];


  bool _isFirstTime = true;

  //防误触----失效
  Timer _timer;

  ///防误触摸----失效
  void _accidentPrevention(bool isFirstTime, VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 300)}) {
    if (isFirstTime) {
      callback();
    } else {
      _timer?.cancel();
      _timer = Timer(duration, callback);
    }
  }

  ///添加局部刷新
  void _addState(_StatefulState state) {
    ///判断是对比差别方式还是key方式
    if (!_listState.contains(state)) {
      _listState.add(state);
    }
  }

  ///删除局部刷新
  void _removeState({_StatefulState state}) {
    if (state != null) {
      if (_listState.contains(state)) {
        _listState.remove(state);
      }
    }
  }

  void _registerState(__PageWidgetState state) {
    this._state = state;
  }

  ///  跳转路由。
  ///  需要自定义路由调用routeBuilder
  Future<dynamic> push(BuildContext context,
      {RouteBuilder routeBuilder = _kRouteBuild}) async {
    return await Navigator.of(context).push(routeBuilder(this.page.widget));
  }

  ///刷新
  void setState([VoidCallback callback]) {
    if (callback != null) {
      callback();
    }
    //判断stateful.bind有没有改变
    bool isDiff = false;
    for (var value in _listState) {
      if (value.setDiffState()) {
        isDiff = true;
      }
    }
    //没有改变，整体刷新
    if (!isDiff) {
      setRootState();
    }
  }

  ///整体刷新
  void setRootState() {
    _setState(_state);
  }

  void _setState(State state) {
    try {
      if (state?.mounted) {
        state?.setState(() {});
      }
    } catch (e) {
      print(e);
      Future.delayed(Duration(milliseconds: 50), () {
        _setState(state);
      });
    }
  }

  void initState() {}

  void onResume() {}

  void onPause() {}

  void dispose() {
    _isFirstTime = true;
    _timer?.cancel();
  }

  void showLoading({String text}) {
    _loadingController.showLoading();
  }

  void dismissLoading() {
    _loadingController.dismissLoading();
  }
}

class MvcConfig{
//  重新回到当前界面时，是否调用回掉方法onResume()
  var canResume=true;
  //  跳转其他界面或者当前界面不可见时，是否调用回掉方法onPause()
  var canPause=true;
  __PageWidgetState _state;
  //获取page
  BasePage get page=>_state.basePage;
  //获取controller
  BaseController get controller=>_state.basePage._controller;
  ///获取所有的当前界面所有的stateful bind集合
  List<_StatefulState> get listStatefulState{
    return controller._listState;
  }
  ///loading动画
  LoadingController get loadingController=>controller._loadingController;
}
