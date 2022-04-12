import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_blood_belfry/page/main_page.dart';

///
class RouteName {

  ///主页面
  static const String mainPage = 'mainPage';
  ///登录页面
  static const String loginPage = 'loginPage';
}

///用于main MaterialApp配置 onGenerateRoute
class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainPage:
        return FadePageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const MainPage(),
        );
      default:
        return FadePageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'No route defined for ${settings.name}',
                      textScaleFactor: 1,
                    ),
                  ),
                ));
    }
  }
}
