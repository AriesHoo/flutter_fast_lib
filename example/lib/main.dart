import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/generated/l10n.dart';
import 'package:flutter_fast_lib_example/main_tab_page.dart';
import 'package:flutter_fast_lib_example/manager/router_manger.dart';
import 'package:flutter_fast_lib_example/mixin/fast_lib_mixin.dart';
import 'package:flutter_fast_lib_example/theme/app_theme_data.dart';

///全局获取国际化语言
S get appString => S.of(currentContext);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///滚动性能优化 1.22.0
  GestureBinding.instance.resamplingEnabled = true;
  // 同步初始化FastSpUtil
  await FastSpUtil.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FastLogUtil.e('isInitialized:${FastSpUtil.initialized()}');
  }

  @override
  Widget build(BuildContext context) {
    return FastLibInit(
      ///初始化各种配置-包括网络请求、下拉刷新等如果想单独设置某个可使用[FastManager.setMixin]
      fastLibMixin: fastLibMixin,

      ///是否异步初始化[FastSpUtil]如果想同步执行则自己在main方法调用FastSpUtil.initialize
      initializeSp: true,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      home: const MainTabPage(),
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'FlutterFastLib',
      onGenerateRoute: RouterManager.generateRoute,
    );
  }
}
