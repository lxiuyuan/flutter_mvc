import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/src/manager.dart';
import 'loading.dart';
import 'widget.dart';


///Page基类
abstract class BasePage<T extends BaseController> {
  __PageWidgetState _state;
  BaseController _controller;

  ///获取内部变量 mvc config
  static MvcAttribute getMvcAttribute(BasePage page) {
    return page._state.mvcAttribute;
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

///通过此类将mvc运行到界面中
class _PageWidget extends StatefulWidget {
  final BasePage basePage;

  _PageWidget(this.basePage);

  @override
  __PageWidgetState createState() => __PageWidgetState();
}

class __PageWidgetState extends State<_PageWidget>
    with SingleTickerProviderStateMixin {
  BasePage basePage;

  ///参数
  ///外部组件改造内部变量
  MvcAttribute get mvcAttribute=>widget.basePage._controller._mvcAttribute;

  @override
  void initState() {
    mvcAttribute.state = this;
    this.basePage = widget.basePage;
    basePage._registerState(this);
    basePage.initState();
    basePage._controller?.initState();
    if (mvcAttribute.canManager) {
      MvcManager.instance.addController(basePage.controller);
      MvcManager.instance.resume(basePage.controller);
    }
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
    if (mvcAttribute.canManager) {
      MvcManager.instance.resume(basePage.controller);
    }
    //判断是否允许
    if (!mvcAttribute.canResume) {
      return;
    }
    basePage.onResume();
    basePage._controller?.onResume();
  }

  void onPause() {
    if (!mvcAttribute.canPause) {
      return;
    }
    basePage.onPause();
    basePage._controller?.onPause();
  }

  @override
  void dispose() {
    if (mvcAttribute.canManager) {
      MvcManager.instance.removeController(basePage.controller);
    }
    basePage.dispose();
    basePage._controller?.dispose();
    super.dispose();
  }
  ///创建loading 样式组件
  Widget createLoadingWidget(){
    return Center(
      child: SizedBox(
          width: 28,
          height: 28,
          child: CupertinoActivityIndicator(
            radius: 15,
          )),
    );
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
              child: createLoadingWidget(),
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

//根据controller创建动画controller
AnimationController createAnimationControllerByController(
    {double value,
    Duration duration,
    Duration reverseDuration,
    String debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    @required BaseController controller}) {
  var animationController = AnimationController(
      value: value,
      duration: duration,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      lowerBound: lowerBound,
      upperBound: upperBound,
      vsync: controller._state);
  return animationController;
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
  static MvcAttribute getMvcAttribute(BaseController c) {
    return c._mvcAttribute;
  }

  MvcAttribute _mvcAttribute = MvcAttribute();

  __PageWidgetState _state;
  BasePage page;
  Widget get widget => page.widget;

  ///菊花圈控制器
  LoadingController _loadingController;

  BuildContext get context => _state?.context;

  ///注册内部state
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
  ///优先刷新Stateful
  ///Stateful没有刷新是全局刷新
  void setState([VoidCallback callback]) {
    if (callback != null) {
      callback();
    }
    //判断stateful.bind有没有改变
    bool isDiff = false;
    for (var value in _mvcAttribute.listStateful) {
      if (value.setDiffState()) {
        isDiff = true;
      }
    }
    //没有改变，全局刷新
    if (!isDiff) {
      setRootState();
    }
  }

  ///全局刷新
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
  }

  void showLoading({String text}) {
    _loadingController.showLoading();
  }

  void dismissLoading() {
    _loadingController.dismissLoading();
  }
}

class MvcAttribute {
//  是否进入管理器
  var canManager = true;
//  重新回到当前界面时，是否调用回掉方法onResume()
  var canResume = true;
  //  跳转其他界面或者当前界面不可见时，是否调用回掉方法onPause()
  var canPause = true;

  //获取page
  BasePage get page => state.basePage;
  //获取controller
  BaseController get controller => state.basePage._controller;
  ///获取所有的当前界面所有的stateful bind集合
  List<StatefulState> listStateful=[];
  __PageWidgetState state;

  ///loading动画
  LoadingController get loadingController => controller._loadingController;

}
