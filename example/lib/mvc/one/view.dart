import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:第一个界面
class OnePage extends BasePage<OneController> {
  @override
  Widget build(BuildContext context) {
    print("OnPage Build");
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.title}"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(

          children: <Widget>[
            SizedBox(height: 50,),
            DemoStateless(),
            DemoStateful(),
            Stateful(bind: ()=>[c.text],builder: (ctx){
              return Text(c.text);
            },),
            SizedBox(height: 50,),
            FlatButton(onPressed: c.onStatelessClick, child: Text("statelessText Change")),
            FlatButton(onPressed: c.onStatefulClick, child: Text("statefulText Change")),
            FlatButton(onPressed: c.onTextClick, child: Text("text Change")),
            FlatButton(onPressed: c.onAllClick, child: Text("all Change"))
          ],
        ),
      ),
    );
  }
}

class DemoStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Stateless Build");
    return ControllerBuilder(
      builder: (OneController c) {
        return Stateful(
          bind: () => [c.statelessText],
          builder: (ctx) {
            return Text(c.statelessText);
          },
        );
      },
    );
  }
}

class DemoStateful extends StatefulWidget {
  @override
  _DemoStatefulState createState() => _DemoStatefulState();
}

class _DemoStatefulState extends BaseState<DemoStateful, OneController> {
  @override
  Widget build(BuildContext context) {
    print("Stateful Build");
    return Stateful(
      bind: () => [c.statefulText],
      builder: (ctx) {
        return Text(c.statefulText);
      },
    );
  }
}
