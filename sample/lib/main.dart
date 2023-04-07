import 'package:flutter/material.dart';
import 'package:flutter_blood_belfry/constant/app_constant.dart';
import 'package:flutter_blood_belfry/generated/l10n.dart';
import 'package:flutter_blood_belfry/helper/analytics_helper.dart';
import 'package:flutter_blood_belfry/manager/route_manager.dart';
import 'package:flutter_blood_belfry/mixin/fast_lib_mixin.dart';
import 'package:flutter_blood_belfry/page/main_page.dart';
import 'package:flutter_blood_belfry/theme/app_theme_data.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

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
  runApp(const AppInit());
  Future.delayed(
    const Duration(milliseconds: 500),
    () => AppThemeData.setSystemBarTheme(),
  );
}

class AppInit extends StatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> with WidgetsBindingObserver {
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
      navigatorObservers: [
        ///统计页面切换及停留时间
        AnalyticsHelper.getInstance().getAnalyticsRouteObserver()!,
      ],
      // initialRoute: RouteName.mainPage,
      home: const MainPage(),
    );
  }

  @override
  void initState() {
    super.initState();

    ///添加监听用于监控前后台转换
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!FastPlatformUtil.isAndroid) {
      return;
    }

    ///应用前台
    if (state == AppLifecycleState.resumed) {
      AppThemeData.setSystemBarTheme();
    }
  }
}
