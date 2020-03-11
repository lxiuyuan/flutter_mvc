
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class FragmentWidget extends StatefulWidget {
  final List<BaseController> children;
  final FragmentController controller;

  FragmentWidget({@required this.controller,  this.children});

  @override
  _FragmentWidgetState createState() => _FragmentWidgetState();
}

class _FragmentWidgetState extends State<FragmentWidget> {
  FragmentController controller;

  @override
  void initState() {
    this.controller = widget.controller;
    controller._registerState(this);

    controller.firstResume();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        key: controller._stackKey,
        index: controller.index,
        children: widget.children.map((BaseController controller){
          return controller.page.widget;
        }).toList(),
      ),
    );

  }
}







class FragmentController {
  State _state;
  int index=0;
  FragmentWidget get widget{
    if(_state?.widget==null){
      return null;
    }
    return _state.widget as FragmentWidget;
  }
  GlobalKey _stackKey=GlobalKey();
  void _registerState(State state){
    this._state=state;
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

  bool _isFirst=true;
  void firstResume() async {
    if(!_isFirst){
      return;
    }
    _isFirst=false;
    await Future.delayed(Duration(milliseconds: 50));
    resume();
  }
  ///重新渲染回调，
  void resume(){
    if(widget==null){
      return;
    }
    var baseController=widget.children[this.index];
    baseController.onResume();
    baseController.page?.onResume();
  }

  //暂停回掉
  void pause({int i}){
    if(widget==null){
      return;
    }
    var index=i??this.index;
    var baseController=widget.children[index];
    baseController.onPause();
    baseController.page?.onPause();
  }

  void animToPage(int index){
    var oldIndex=this.index;
    this.index=index;
    _setState();
    resume();
    pause(i:oldIndex);
  }


}
