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
            SizedBox(
              height: 50,
            ),
            DemoStateless(),
            DemoStateful(),
            Stateful(
              bind: () => [c.text],
              builder: (ctx) {
                return Text(c.text);
              },
            ),
            SizedBox(
              height: 50,
            ),
            OutlineButton(
                onPressed: c.onStatelessClick,
                child: Text("statelessText Change")),
            OutlineButton(
                onPressed: c.onStatefulClick,
                child: Text("statefulText Change")),
            OutlineButton(onPressed: c.onTextClick, child: Text("text Change")),
            OutlineButton(onPressed: c.onAllClick, child: Text("all Change")),
            Expanded(child: Test())

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
        return LocalBind(
          bind: () => [c.statelessText],
          child: Text(c.statelessText),
        );
      },
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          LocalBind(
            bind: () => [],
            child: SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return Container(height: 20,color: Colors.green,margin: EdgeInsets.only(top: 2,left: 10,right: 10),);
              }, childCount: 10),
            ),
          )
        ],
      ),
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
        return Text("w");
      },
    );
  }
}

class ThisStateful extends StatefulWidget {
  @override
  _ThisStatefulState createState() => _ThisStatefulState();
}

class _ThisStatefulState extends BaseState<ThisStateful, OneController> {
  @override
  Widget build(BuildContext context) {
    return Text(c.text);
  }
}
