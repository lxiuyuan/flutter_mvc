# flutter_mvc教程

# 0.1. 安装插件
`pubspec.yaml`
```yaml
  flutter_mvc:
    git: https://github.com/lxiuyuan/flutter_mvc.git
```

# 0.2. 安装idea插件
### mvc插件本地安装
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

# 3.创建view.dart，controller.dart（idea插件创建）

![](https://njc-download.weiyun.com/ftn_handler/4cfd9b79b3f6ca1881afa18ea1a0f95502f63574210a04607b1c727351169b45ebe6e065f0dd49f5f69cafd6e304b461e0889f538a7ab555531e7baaab727982/cueqf-9bdx2.gif?fname=cueqf-9bdx2.gif&from=30013&version=3.3.3.3)