# flutter_mvc函数介绍
## 1.MvcMaterialApp
#### ⠀作用：计算备用生命周期
- isStandbyLifecycle备用生命周期<br/>
  1.17官方生命周期有bug，可以启动备用生命周期
  ```Dart
  isStandbyLifecycle: true,
  ```
## 2.获取controller组件
- ControllerBuilder(Builder获取Controller)
 ```Dart
 ControllerBuilder(builder:(ThisController c){
   return Text(c.text);
 })
 ```
- MvcStatelessWidget(StatelessWidget获取controller)
 ```
 class ThisStatelessWidget extends MvcStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(c.text);
  }
}
 ```
- MvcState(StatefulWidget获取controller)
 ```Dart
 class _ThisStatefulWidgetState extends MvcState<ThisStatefulWidget,ThisController> {
  @override
  Widget build(BuildContext context) {
    return Text(c.text);
  }
}

 ```
## 3.BasePage(view.dart)
- 界面要当前类下面
- 属性c、controller 来获取当前对应的BaseController对象
## 4.Stateful
- 局部刷新<br/>
bing：要绑定的变量<br/>
builder:要build的视图
 ```Dart
 Stateful(
 	bind:()=>[],
 	builder:(context){
    	return widget;
 })
 ```

  
## 4.BaseController(controller.dart)
* 构造函数
  ```Dart
  ThisController():BaseController(ThisPage());
  ```
* 获取widget<br/>
 ```Dart
 new ThisController().widget;
 ```
- 跳转路由
 ```Dart
 new ThisController.push(context);
 ```
- 关闭界面<br/>
 ```Dart
  pop(value);
 ```
- 展示菊花圈<br/>
 ```Dart
 showLoading();
 ```
- 关闭菊花圈<br/>
 ```Dart
 dismissLoading();
 ```
- 刷新状态（局部）<br/>
刷新有变化的Stateful组件,否则刷新view.dart
 ```Dart
 setState((){
 });
 ```
- 刷新状态<br/>
刷新view.dart
 ```Dart
 setRootState();
 ```

#### ⠀生命周期
- 初始化
 ```Dart
  @override
   void initState(){
       super.initState();
   }
 ```
- 销毁
 ```Dart
  @override
  void dispose() {
    super.dispose();
  }
 ```
- 界面从被覆盖、后台重新回到前台时被调用  
 ```Dart
  @override
  void onResume() {
    super.onResume();
  }
 ```
- 界面被覆盖到下面或者锁屏时被调用  
 ```Dart
  @override
  void onPause() {
    super.onPause();
  }
 ```
 
 

 