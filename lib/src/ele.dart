import 'package:flutter/cupertino.dart';
import 'widget.dart';

import '../flutter_mvc.dart';

class MvcStatelessElement extends StatelessElement {
  MvcStatelessElement(MvcStatelessWidget widget) : super(widget){
    widget.element=this;
  }


  Widget build(){
    (widget as MvcStatelessWidget).element=this;
    return super.build();

  }

  BaseController  _controller;
  BaseController get controller{
    if(_controller==null){
      var inherited = ControllerInherited.of(this);
      _controller = inherited.controller;
    }
     return _controller;
  }

}
