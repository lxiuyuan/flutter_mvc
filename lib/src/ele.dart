import 'package:flutter/cupertino.dart';
import 'widget.dart';

import '../flutter_mvc.dart';

class MvcStatelessElement extends StatelessElement {
  MvcStatelessElement(MvcStatelessWidget widget) : super(widget){
    widget.element=this;
  }


  @override
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

class MvcInheritedElement extends InheritedElement{
  ControllerInherited w;
  MvcInheritedElement(this.w) : super(w);

  @override
  void mount(Element parent, dynamic newSlot) {
    w.parentContext=parent;
    super.mount(parent, newSlot);
  }

  @override
  Widget build(){
    w.context=this;
    return super.build();

  }
}
