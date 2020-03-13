import 'dart:async';

import 'package:flutter/services.dart';
export 'src/page.dart';
export 'src/fragment/view.dart';
export 'src/animation.dart';
export 'src/manager.dart';
export 'src/widget.dart' show Stateful,ControllerBuilder,BaseState;
class FlutterMvc {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mvc');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
