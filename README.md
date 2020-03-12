# flutter_mvc
mvc是分离UI跟业务逻辑的框架<br/>
# 特点
* 生命周期完善
* 逻辑清晰
* 提高效率
* 状态控制视图
* diff算法优化没必要的build

## 介绍
### 1.Stateful：
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
### 2.子控件获取BasePage下controller
#### 2.1. ControllerBuild
* 获取BasePage下的ThisController

```Dart
ControllerBuilder(
  builder: (ThisController c) {
    return Text(c.statelessText);
  },
);
```
<br/>

#### 2.2. BaseState:
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

### example文件夹是运行demo
