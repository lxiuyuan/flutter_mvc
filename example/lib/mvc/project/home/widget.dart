import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_mvc_example/common/widget/tab/view.dart';
import 'controller.dart';



//顶部标题
class HeaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Color(0xffff4444)),
          gradient: LinearGradient(colors: [
            Color(0xffff5555),
            Color(0xffff4444),
          ])),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 70,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15, right: 15,top: 15),
          child: Container(
            height: 32,
            padding: EdgeInsets.only(left: 7, right: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32), color: Colors.white),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color(0xffbbbbbb),
                  size: 25,
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                    child: Text("搜索商品关键字",
                        style: TextStyle(
                          inherit: false,
                          fontSize: 14,
                          height: 1,
                          color: Color(0xffbbbbbb),
                        ))),
                Icon(
                  Icons.camera_alt,
                  color: Color(0xffbbbbbb),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(builder: (HomeController c) {
      return Container(
        height: 40,

        margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          border: Border.all(width: 0,color: Color(0xffff4444)),
            gradient: LinearGradient(colors: [
              Color(0xffff5555),
              Color(0xffff4444),
            ])),
        child: TabScrollWidget(
          controller: c.tabController,
          padding: EdgeInsets.only(left: 15,right: 15),
          builder: (ctx, index, isSelect) {
            return TabItem(padding: EdgeInsets.only(left: 8, right: 8),
              child: Text("${c.tabs[index]}",style: TextStyle(inherit: false,color: Colors.white,fontSize: 15),),);
          },
          length: c.tabs.length,
          lineWidget: Container(
            height: 2,
            margin: EdgeInsets.only(bottom: 1),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(2)),
          ),
        ),
      );
    });
  }
}
