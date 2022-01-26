import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/page/download_app_page.dart';
import 'package:flutter_fast_lib_template/page/home_page.dart';

///
class RouteName {
  ///主页面-项目主页面WEB端主页
  static const String home = 'home';

  ///下载app页面
  static const String downloadApp = 'downloadApp';

  ///后台-登录
  static const String adminLogin = 'admin/login';

  ///后台-主页面
  static const String adminIndex = 'admin/index';
}

///用于main MaterialApp配置 onGenerateRoute
class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return FadePageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const HomePage(),
        );
      case RouteName.downloadApp:
        return FadePageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const DownloadAppPage(),
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
