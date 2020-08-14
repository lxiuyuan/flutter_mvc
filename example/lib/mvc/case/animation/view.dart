import 'package:flutter_mvc_example/common/widget/appbar.dart';
import 'package:flutter_mvc_example/mvc/case/widget/widget.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:动画
class AnimationDemoPage extends BasePage<AnimationDemoController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1f1f1),
      child: Column(
        children: <Widget>[
          WhiteAppBar(
            "动画",
            visibleLeftButton: false,
          ),
          Group(
              Stateful(
                bind: () => [c.animationValue],
                builder: (context) => Opacity(
                  opacity: c.animationValue,
                  child: Text(
                    "MvcAnimationController",
                    style: TextStyle(
                        inherit: false, color: Color(0xff3c3c3c), fontSize: 15),
                  ),
                ),
              ),
              OutlineButton(onPressed: c.onAnimationClick,child: Text("anim"),))
        ],
      ),
    );
  }
}
