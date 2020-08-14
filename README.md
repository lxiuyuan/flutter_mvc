# flutter_mvc
分离UI跟业务逻辑的框架(动静分离)
# 特点
* 生命周期完善
* 动静分离
* 逻辑清晰
* 提高效率
* diff算法优化性能

# INSTALL
```Flutter
  flutter_mvc:
    git: https://github.com/lxiuyuan/flutter_mvc.git
```

# AndroidStudio Plugin<br/>
* 快速生成mvc基础代码
* 右侧维护mvc列表
* 快速生成fluro代码
* json to dart <br/>
### [安装插件](https://github.com/lxiuyuan/flutter_mvc/tree/master/plugin)
<br/>
<br/>
<br/>

# 开始 
### 引用```MvcMaterialApp```替换```MaterialApp```
```Dart
    MvcMaterialApp(
          home: ...,
    );
```

# Controller <br/>
 ```var controller=new Controller();```
* 跳转界面：```controller.push(context);```
* 关闭界面: ```controller.pop(result);```
* 获取widget跳转:
 ```Dart
Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
   new Controller().widget;
}));
```


# 其他组件介绍<br/>

## 1.Stateful：

```Dart
Stateful(
  ///绑定用到的变量
  bind: ()=>[c.text],
  builder: (ctx){
    return Text(c.text);
  },
)
``` 

`controller.setState((){})`的时候会根据算法进行进行刷新<br/>



## 2.子控件获取BasePage下controller<br/>

### 2.1. ControllerBuild

* 获取BasePage下的ThisController

```Dart
Widget build(context){
  return ControllerBuilder(
    builder: (ThisController c) {
      return Text(c.statelessText);
    },
  );
}
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

controller.dart

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
`view.dart`
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

# 管理组件MvcManager：
* Mvc
* 可以获取到app全部的BaseController
* current:获取当前显示的Controller

# example
* 基础用法
* demo-Home界面:<br/>
文件:<br/>
[controller.dart](https://github.com/lxiuyuan/flutter_mvc/blob/master/example/lib/mvc/demo/home/controller.dart)<br/>
[view.dart](https://github.com/lxiuyuan/flutter_mvc/blob/master/example/lib/mvc/demo/home/view.dart)<br/>
预览：
![](https://raw.githubusercontent.com/lxiuyuan/flutter_mvc/master/images/home.jpg)

