import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/mixin/default_fast_lib_mixin.dart';
import 'package:flutter_fast_lib/src/util/fast_log_util.dart';
import 'package:flutter_fast_lib/src/util/fast_sp_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///全局key
GlobalKey<NavigatorState> fastLibNavigatorKey = GlobalKey<NavigatorState>();

///全局Context
BuildContext get currentContext =>
    (fastLibNavigatorKey.currentContext ?? _context)!;

///FastLibInit的BuildContext
BuildContext? _context;

///FastLib Init--扩展MaterialApp增加全局配置
///1、2021-12-02 09:59 修改为[StatefulWidget]并增加[FastManager]初始化及[FastSpUtil]初始化
///2、2021-12-20 09:21 增加[textScaleFactor] [boldText]用于控制应用是否受系统设置影响
///3、2023-04-07 10：20 初步升级Flutter3.0并移除部分默认配置(themeData)
class FastLibInit extends StatefulWidget {
  const FastLibInit({
    Key? key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.hideKeyboardWhenPressOtherWidget = true,
    this.fastLibMixin,
    this.initializeSp = true,
    this.mediaQueryData,
    this.textScaleFactor = 1.0,
    this.boldText,
    this.resizeToAvoidBottomInset,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder> routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;

  ///当点击其它widget关闭软键盘
  final bool hideKeyboardWhenPressOtherWidget;

  ///DefaultFastLibMixin
  final DefaultFastLibMixin? fastLibMixin;

  ///是否初始化[FastSpUtil]
  ///iPhone模拟器 1-1.5秒
  ///Android 模拟器0.9-2.4秒 真机 1秒左右
  final bool initializeSp;

  ///默认使用[MediaQuery.of(context)]
  final MediaQueryData? mediaQueryData;

  ///缩放因子-控制应用是否受系统字号控制
  final double textScaleFactor;

  ///是否粗体文字
  final bool? boldText;

  ///Scaffold 用于控制底部有输入框页面是否自动留出位置
  final bool? resizeToAvoidBottomInset;

  @override
  _FastLibInitState createState() => _FastLibInitState();
}

class _FastLibInitState extends State<FastLibInit> {
  @override
  void initState() {
    _context = context;
    FastLogUtil.e('initState_context:$context;currentContext:$currentContext',
        tag: 'FastLibInitTag');
    if (widget.fastLibMixin != null) {
      FastManager.getInstance().setMixin(defaultMixin: widget.fastLibMixin);
    }
    if (widget.initializeSp) {
      FastSpUtil.initialize();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FastLibInit oldWidget) {
    super.didUpdateWidget(oldWidget);

    FastLogUtil.e(
      'oldTheme:${oldWidget.theme?.colorScheme.primary};newTheme:${oldWidget.theme?.colorScheme.primary}',
      tag: 'FastInitTag',
    );
  }

  @override
  Widget build(BuildContext context) {
    FastLogUtil.e('build_context:$context;currentContext:$currentContext',
        tag: 'FastLibInitTag');

    ///路由
    List<NavigatorObserver> observers = [];
    if (ObjectUtil.isNotEmpty(widget.navigatorObservers)) {
      observers.addAll(widget.navigatorObservers!);
    }

    ///添加Toast监听-ToastMixin
    observers.add(BotToastNavigatorObserver());

    ///添加生命周期监听-Lifecycle observer
    observers.add(defaultLifecycleObserver);

    ///国际化配置
    List<LocalizationsDelegate<dynamic>> listLocalizationsDelegates = [
      ///下拉刷新库国际化配置
      RefreshLocalizations.delegate,

      ///不配置该项会在EditField点击弹出复制粘贴工具时抛异常 The getter 'cutButtonLabel' was called on null.
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ];
    if (widget.localizationsDelegates != null) {
      listLocalizationsDelegates
          .addAll(widget.localizationsDelegates!.toList());
    }

    ///支持语言
    List<Locale> listSupportedLocales = [
      const Locale('en', 'US'),
      const Locale('zh', 'CN'),
    ];
    listSupportedLocales.addAll(widget.supportedLocales);

    ///软键盘控制
    ///参考http://laomengit.com/blog/20200909/DismissKeyboard.html
    TransitionBuilder? keyboardBuilder;
    if (widget.hideKeyboardWhenPressOtherWidget) {
      ///此处需要Scaffold包裹否则报错To introduce a Material widget, you can either directly include one, or use a widget that contains Material itself, such as a Card, Dialog, Drawer, or Scaffold.
      ///https://blog.csdn.net/yechaoa/article/details/90693377
      keyboardBuilder = (context, child) => Scaffold(
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                ///当前有获取焦点的控件
                if (currentFocus.focusedChild != null) {
                  ///关闭软键盘方式一
                  FocusManager.instance.primaryFocus?.unfocus();

                  ///关闭软键盘方式二-channel
                  // SystemChannels.textInput.invokeMethod('TextInput.hide');

                  ///关闭软键盘方式三-焦点转移
                  // FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              child: child,
            ),
          );
    }

    ///GlobalKey
    fastLibNavigatorKey = widget.navigatorKey ?? fastLibNavigatorKey;

    ///Toast Builder
    ///这个位置不要乱调整-否则可能出现未知问题;如Android 返回键拦截失效等问题
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      navigatorKey: fastLibNavigatorKey,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      home: widget.home,
      routes: widget.routes,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onUnknownRoute: widget.onUnknownRoute,
      navigatorObservers: observers,
      builder: (context, kid) {
        ///添加toast
        kid = botToastBuilder(context, kid);

        ///添加外部builder
        if (widget.builder != null) {
          kid = widget.builder!(context, kid);
        }

        ///添加软键盘控制
        if (keyboardBuilder != null) {
          kid = keyboardBuilder(context, kid);
        }

        ///设置应用配置是否受系统影响
        return MediaQuery(
          data: (widget.mediaQueryData ?? MediaQuery.of(context)).copyWith(
            textScaleFactor: widget.textScaleFactor,
            boldText: widget.boldText,
          ),
          child: kid,
        );
      },
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      localizationsDelegates: listLocalizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: listSupportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
    );
  }
}
