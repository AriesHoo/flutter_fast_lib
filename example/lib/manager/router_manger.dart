import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/page/index/fast_channel_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_dialog_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_dialog_util_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_loading_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_sp_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_tab_bar_page.dart';
import 'package:flutter_fast_lib_example/page/index/fast_toast_page.dart';
import 'package:flutter_fast_lib_example/page/index/qq_title_bar_page.dart';

class RouteName {
  static const String fastTabBarPage = 'fast_tab_bar_page';
  static const String qqTitleBarPage = 'qq_title_bar_page';
  static const String fastToastPage = 'fast_toast_page';
  static const String fastDialogPage = 'fast_dialog_page';
  static const String fastLoadingPage = 'fast_loading_page';
  static const String fastSpPage = 'fast_sp_page';
  static const String fastChannelPage = 'fast_channel_page';
  static const String fastDialogUtilPage = 'fast_dialog_util_page';
}

///用于main MaterialApp配置 onGenerateRoute
class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.fastTabBarPage:
        return FadePageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (BuildContext context) => const FastTabBarPage(),
        );
      case RouteName.qqTitleBarPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const QQTitleBarPage(),
        );
      case RouteName.fastToastPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastToastPage(),
        );
      case RouteName.fastDialogPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastDialogPage(),
        );
      case RouteName.fastLoadingPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastLoadingPage(),
        );
      case RouteName.fastSpPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastSpPage(),
        );
      case RouteName.fastChannelPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastChannelPage(),
        );
      case RouteName.fastDialogUtilPage:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => const FastDialogUtilPage(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'No route defined for ${settings.name}',
                    ),
                  ),
                ));
    }
  }
}
