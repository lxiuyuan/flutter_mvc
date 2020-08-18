# flutter_mvc教程
# 目录

#### [0.环境安装](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#0%E7%8E%AF%E5%A2%83%E5%AE%89%E8%A3%85-1)
* [0.1安装插件](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#01-%E5%AE%89%E8%A3%85%E6%8F%92%E4%BB%B6)
* [0.2. 安装idea插件](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#02-%E5%AE%89%E8%A3%85idea%E6%8F%92%E4%BB%B6)
#### [1. 初始化MvcMaterialApp](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#1-%E5%88%9D%E5%A7%8B%E5%8C%96mvcmaterialapp-1)
#### [2.创建mvc（idea插件创建）](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#2%E5%88%9B%E5%BB%BAmvcidea%E6%8F%92%E4%BB%B6%E5%88%9B%E5%BB%BA-1)
#### [3.启动controller](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#3%E5%90%AF%E5%8A%A8controller-1)
* [3.1首页方式启动](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#31-%E9%A6%96%E9%A1%B5%E6%96%B9%E5%BC%8F%E5%90%AF%E5%8A%A8)
* [3.2路由方式启动](https://github.com/lxiuyuan/flutter_mvc/blob/master/JC.md#31-%E9%A6%96%E9%A1%B5%E6%96%B9%E5%BC%8F%E5%90%AF%E5%8A%A8)

# 0.环境安装
### 0.1. 安装插件
`pubspec.yaml`
```yaml
  flutter_mvc:
    git: https://github.com/lxiuyuan/flutter_mvc.git
```

### 0.2. 安装idea插件
##### mvc插件本地安装
[下载插件](https://github.com/lxiuyuan/flutter_mvc/raw/master/plugin/flutter_mvc.zip)
[安装教程](https://www.jianshu.com/p/ba154b1518ec)<br/>

# 1. 初始化MvcMaterialApp
`main.dart`
```Dart
  @override
  Widget build(BuildContext context) {
    //需要用MvcMaterialApp代替MaterialApp
    return MvcMaterialApp(
      //是否启动备用生命周期计算onResume，onPause
      //false:启动google提供的方式（1.17版本有bug）
      isStandbyLifecycle: true,
      home:Builder(builder: (context) {
        return Scaffold(
        );
      }),
    );
  }
```

# 2.创建mvc（idea插件创建）

![gif](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a7a1537a01a545308da600250857b766~tplv-k3u1fbpfcp-zoom-1.image)


# 3.启动controller
#### 3.1 首页方式启动
`main.dart`
```Dart
  @override
  Widget build(BuildContext context) {
    return MvcMaterialApp(
      isStandbyLifecycle: true,
      home:ShopController().widget,//在这里打开widget
    );
  }
```
#### 3.2 路由方式启动
```Dart
    new ShopController().push(context);
```



