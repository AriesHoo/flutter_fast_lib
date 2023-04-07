import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/generated/l10n.dart';
import 'package:flutter_fast_lib_template/manager/route_manager.dart';
import 'package:flutter_fast_lib_template/mixin/fast_lib_mixin.dart';
import 'package:flutter_fast_lib_template/page/home_page.dart';
import 'package:flutter_fast_lib_template/theme/app_theme_data.dart';

///全局String国际化对象
S get appString => S.of(currentContext);

///清空所有Toast
void clearToast() {
  BotToast.removeAll();
}

void main() async {
  ///全局设置当前环境--默认正式环境
  AppConstant.setEnvironment(Environment.test);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  WebBrowserInfo info = await FastPlatformUtil.getDeviceInfo();
  FastLogUtil.e(
      'browserName${info.browserName}'
      ';userAgent:${info.userAgent}'
      ';platform:${info.platform}'
      ';index:${Environment.production.index}'
      ';name:${Environment.production.name}'
      ';product:${info.product}',
      tag: 'getDeviceInfoTag');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FastLibInit(
      fastLibMixin: fastLibMixin,
      debugShowCheckedModeBanner: false,
      title: AppConstant.appTitle,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      onGenerateRoute: RouteManager.generateRoute,
      locale: const Locale('zh-CN'),

      ///国际化语言
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: RouteName.home,
      home: const HomePage(),
    );
  }
}
