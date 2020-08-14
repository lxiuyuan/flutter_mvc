import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_mvc_example/mvc/controller.dart';
import 'package:flutter_mvc_example/mvc/one/controller.dart';
import 'package:flutter_mvc_example/mvc/route_test/one/controller.dart';
import 'mvc/case/controller.dart';
import 'mvc/project/home/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterMvc.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    //需要用MvcMaterialApp代替MaterialApp
    return MvcMaterialApp(
      isStandbyLifecycle: true,
      home:Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
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
