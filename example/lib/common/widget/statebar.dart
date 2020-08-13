import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StateBarFontTheme {
  white,
  black
}

class SystemStateBar extends StatelessWidget {
  final StateBarFontTheme fontTheme;
  final Widget child;

  SystemStateBar({this.fontTheme = StateBarFontTheme.black, this.child});

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle theme;
    if (fontTheme == StateBarFontTheme.black) {
      if (Platform.isAndroid) {
        theme = SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: null,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        );
      } else {
        theme = SystemUiOverlayStyle.dark;
      }
    } else {
      if (Platform.isAndroid) {
        theme = SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: null,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        );
      } else {
        theme = SystemUiOverlayStyle.light;
      }
    }

    return Semantics(
      container: true, child: AnnotatedRegion<SystemUiOverlayStyle>(
      value: theme,
      child: Material(color: Colors.transparent, child: child,),),);
  }
}
