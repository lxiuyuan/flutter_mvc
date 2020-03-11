import 'dart:async';

import 'package:flutter/services.dart';
export 'src/page.dart';
export 'src/fragment/view.dart';
class FlutterMvc {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mvc');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
