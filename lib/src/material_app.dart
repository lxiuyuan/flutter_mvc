import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

import 'navigator.dart';

//管理底层
class MvcMaterialApp extends MaterialApp {
  MvcMaterialApp({
    Key key,
    GlobalKey<NavigatorState> navigatorKey,
    Widget home,
    Map<String, WidgetBuilder> routes = const <String, WidgetBuilder>{},
    String initialRoute,
    RouteFactory onGenerateRoute,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> navigatorObservers,
    TransitionBuilder builder,
    String title = '',
    GenerateAppTitle onGenerateTitle,
    Color color,
    ThemeData theme,
    ThemeData darkTheme,
    ThemeMode themeMode = ThemeMode.system,
    Locale locale,
    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    LocaleListResolutionCallback localeListResolutionCallback,
    LocaleResolutionCallback localeResolutionCallback,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
    bool debugShowMaterialGrid = false,
    bool showPerformanceOverlay = false,
    bool checkerboardRasterCacheImages = false,
    bool checkerboardOffscreenLayers = false,
    bool showSemanticsDebugger = false,
    bool debugShowCheckedModeBanner = true,
    bool isStandbyLifecycle =
        false, //false默认的生命周期，true备用生命周期（意义：1.17版本官方有bug默认周期问题）
  }) : super(
          key: key,
          navigatorKey: navigatorKey,
          home: home,
          routes: routes,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          navigatorObservers: <NavigatorObserver>[
            MvcNavigatorManager.manager..isPauseAndResume = isStandbyLifecycle
          ]..addAll(navigatorObservers??[]),
          title: title,
          onGenerateTitle: onGenerateTitle,
          color: color,
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          locale: locale,
          builder:builder,
          localizationsDelegates: localizationsDelegates,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          debugShowMaterialGrid: debugShowMaterialGrid,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        ) {
    MvcManager.instance.isPauseAndResume = !isStandbyLifecycle;
  }
}

//留壳（暂时没派上用场）
class MvcBuilder extends StatefulWidget {
  final Widget child;

  MvcBuilder({this.child});

  @override
  _MvcBuilderState createState() => _MvcBuilderState();
}

class _MvcBuilderState extends State<MvcBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
