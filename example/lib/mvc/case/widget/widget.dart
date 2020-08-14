import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_mvc_example/mvc/case/widget/controller.dart';
import 'package:flutter_mvc_example/mvc/project/home/controller.dart';

///StatelessWidget+ControllerBuilder+Stateful
class MvcStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("StatelessWidget+Stateful+ControllerBuilder:Build");
    return ControllerBuilder(builder: (WidgetController c) {
      return Stateful(
          bind: () => [c.statelessStatefulIndex],
          builder: (context) => Group(
              Line2Text("StatelessWidget+Stateful+",
                  "ControllerBuilder:${c.statelessStatefulIndex}"),
              OutlineButton(
                onPressed: c.onStatelessStatefulClick,
                child: Text("变化"),
              )));
    });
  }
}

class MvcStatefulWidget extends StatefulWidget {
  @override
  _MvcStatefulWidgetState createState() => _MvcStatefulWidgetState();
}

class _MvcStatefulWidgetState
    extends BaseState<MvcStatefulWidget, WidgetController> {
  @override
  Widget build(BuildContext context) {
    print("BaseState+Stateful:Build");
    return Stateful(
        bind: () => [c.statefulStatefulIndex],
        builder: (ctx) => Group(
            MText("BaseState+Stateful:${c.statefulStatefulIndex}"),
            OutlineButton(
              onPressed: c.onStatefulStatefulClick,
              child: Text("变化"),
            )));
  }
}

class MText extends Text {
  MText(String data)
      : super(
          data,
          maxLines: 3,
          style:
              TextStyle(inherit: false, color: Color(0xff3c3c3c), fontSize: 15),
        );
}

class Line2Text extends StatelessWidget {
  final String text1;
  final String text2;

  Line2Text(this.text1, this.text2);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MText(text1),
        MText(text2),
      ],
    );
  }
}

class Group extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;

  Group(this.leftChild, this.rightChild);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only( top: 8),
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[leftChild, rightChild],
      ),
    );
  }
}
