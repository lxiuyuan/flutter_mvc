# flutter_mvc
mvc是分离UI跟业务逻辑的框架<br/>
# 特点
* 生命周期完善
* 逻辑清晰
* 提高效率
* 状态控制视图
* diff算法优化性能

# 介绍

## 1.Stateful：

``` Dart

Stateful(
  ///绑定用到的变量
  bind: ()=>[c.text],
  builder: (ctx){
    return Text(c.text);
  },
)
``` 

`controller.setState((){})`的时候会根据算法进行进行刷新<br/>

<br/>

## 2.子控件获取BasePage下controller

### 2.1. ControllerBuild

* 获取BasePage下的ThisController

```Dart
ControllerBuilder(
  builder: (ThisController c) {
    return Text(c.statelessText);
  },
);

```

### 2.2. BaseState:

* 获取BasePage下的ThisController

```Dart

class ThisStateful extends StatefulWidget {
  @override
  _ThisStatefulState createState() => _ThisStatefulState();
}

class _ThisStatefulState extends BaseState<ThisStateful,ThisController> {
  @override
  Widget build(BuildContext context) {
    return Text(c.text);
  }
}

```

<br/>

## 3.FragmentWidget
* 类似于淘宝切换首页、分类、购物车的组件
* 生命周期完善
* 需要传递controller数组<br/>

view.dart

```Dart
class MainController extends BaseController {
   
   MainController():super(MainPage());
   var fragmentController=FragmentController();
   @override
   void initState(){
       super.initState();
       
   }

   void setPage(int index){
     fragmentController.animToPage(index);
   }
   
}
```
`controller.dart`
```Dart
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

```

#管理组件MvcManager：
* Mvc
* 可以获取到app全部的BaseController
* current

# example文件夹下可以运行demo
