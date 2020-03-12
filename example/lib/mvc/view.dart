import 'package:flutter_mvc_example/mvc/one/controller.dart';
import 'package:flutter_mvc_example/mvc/one/view.dart';
import 'package:flutter_mvc_example/mvc/two/controller.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:主页
class MainPage extends BasePage<MainController> {
  var fragments = [OneController(), TwoController()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
              child: FragmentWidget(
            controller: c.fragmentController,
            children: fragments,
          )),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        c.setPage(0);
                      },
                      child: Text("OnePage"))),
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        c.setPage(1);
                      },
                      child: Text("TwoPage"))),
            ],
          )
        ],
      ),
    );
  }
}
