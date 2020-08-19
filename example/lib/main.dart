import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_mvc_example/mvc/route_test/one/controller.dart';
import 'mvc/case/controller.dart';
import 'mvc/project/home/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //需要用MvcMaterialApp代替MaterialApp
    return MvcMaterialApp(
      isStandbyLifecycle: true,
      home:Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('FlutterMvcDemo'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                OutlineButton(
                    onPressed: () {
                      CaseController().push(context);
                    },
                    child: Text("基础用法")),
                OutlineButton(
                  onPressed: () {
                    RouteOneController().push(context);
                  },
                  child: Text("controller.pop的作用"),
                ),

                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){return HomeController().widget;}));
                  },
                  child: Text("实战：Home页"),
                )

              ],
            ),
          ),
        );
      }),
    );
  }
}
