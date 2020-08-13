import 'package:flutter/cupertino.dart';

class MvcStatefulElement extends StatefulElement{
  MvcStatefulElement(StatefulWidget widget) : super(widget);
  Element mvcParent;
  @override
  void mount(Element parent, newSlot) {
    mvcParent=parent;
    super.mount(parent, newSlot);
  }

  void refresh(){
    mvcParent.markNeedsBuild();
    mvcParent.visitChildren((element) {
      if(element!=this){
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('LocalBind invalid.'),
          ErrorDescription(
              "Please use the 'LocalRefresh (child:LocalBind (bing: () = > [...]， Child:...)) '"
          ),
          describeElement(''),
        ]);
      }
    });

  }

}