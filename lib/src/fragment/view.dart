import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class MvcTabView extends StatefulWidget {
  final List<BaseController> children;
  final MvcTabController controller;

  MvcTabView({@required this.controller, this.children});

  @override
  _MvcTabViewState createState() => _MvcTabViewState();
}

class _MvcTabViewState extends State<MvcTabView> {
  MvcTabController controller;

  @override
  void initState() {
    this.controller = widget.controller;
    controller._registerState(this);
    initController();
    controller.firstResume();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  bool isInitListener=false;
  void initListener(BaseController c){
    if(isInitListener) return;
    isInitListener=true;
    var _state=MvcAttribute.getMvcAttributeByController(c).state;
    _state.addOnPauseListener(controller.pause);
    _state.addOnResumerListener(controller.resume);
  }


  var isStart = true;


  void initController() {
    for (var controller in widget.children) {
      BaseController.getMvcAttribute(controller).canPause=false;
      BaseController.getMvcAttribute(controller).canManager=false;
      BaseController.getMvcAttribute(controller).canResume=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(

      builder: (BaseController c) {
        initListener(c);
        return Container(
          child: IndexedStack(
            index: controller.index,
            children: widget.children.map((BaseController controller) {
              return controller.widget;
            }).toList(),
          ),
        );
      }
    );
  }
}

class MvcTabController {
  State _state;
  int index = 0;

  MvcTabView get widget {
    if (_state?.widget == null) {
      return null;
    }
    return _state.widget as MvcTabView;
  }

  GlobalKey _stackKey = GlobalKey();

  void _registerState(State state) {
    this._state = state;
  }

  BuildContext get context => _state?.context;

  void _setState() {
    try {
      if (_state?.mounted) {
        _state?.setState(() {});
      }
    } catch (e) {
      print(e);
      Future.delayed(Duration(milliseconds: 50), () {
        _setState();
      });
    }
  }

  bool _isFirst = true;

  void firstResume() async {
    if (!_isFirst) {
      return;
    }
    _isFirst = false;
    await Future.delayed(Duration(milliseconds: 50));
    resume();
  }

  ///重新渲染回调，
  void resume() {
    if (widget == null) {
      return;
    }
    var baseController = widget.children[this.index];
    baseController.onResume();
    BaseController.getMvcAttribute(baseController).page?.onResume();
  }

  //暂停回掉
  void pause({int i}) {
    if (widget == null) {
      return;
    }
    var index = i ?? this.index;
    var baseController = widget.children[index];
    baseController.onPause();

    BaseController.getMvcAttribute(baseController).page?.onPause();
  }

  void animToPage(int index) {
    var oldIndex = this.index;
    this.index = index;
    _setState();
    resume();
    pause(i: oldIndex);
  }
}
