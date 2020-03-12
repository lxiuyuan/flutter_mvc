# flutter_mvc
mvc是分离UI跟业务逻辑的框架<br/>
## 特点
* 生命周期完善
* 逻辑清晰
* 提高效率
* 状态控制视图
* diff算法优化没必要的build

## 介绍
``` Dart

Stateful(
  ///绑定用到的变量
  bind: ()=>[c.text],
  builder: (ctx){
    return Text(c.text);
  },
)
``` 
`controller.setState((){})`的时候会有点diff算法进行进行刷新

### example文件夹是运行demo
