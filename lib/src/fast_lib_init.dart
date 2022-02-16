import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
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
    this.themeColor,
    this.onGenerateTheme,
    this.onGenerateDarkTheme,
    this.fastLibMixin,
    this.initializeSp = true,
    this.mediaQueryData,
    this.textScaleFactor = 1.0,
    this.boldText,
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

  ///主题色
  final Color? themeColor;

  ///将内部设置好的light主题返回开发者轻度修改
  final ThemeData Function(ThemeData themeData)? onGenerateTheme;

  ///将内部设置好的dark主题返回开发者轻度修改
  final ThemeData Function(ThemeData themeData)? onGenerateDarkTheme;

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

    ///lightTheme
    ThemeData lightThemeData = themeData(
      themeColor: widget.themeColor,
    );

    ///darkTheme
    ThemeData darkThemeData = themeData(
      darkMode: true,
      themeColor: widget.themeColor,
    );

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
      theme: widget.theme ??
          (widget.onGenerateTheme != null
              ? widget.onGenerateTheme!(lightThemeData)
              : lightThemeData),
      darkTheme: widget.darkTheme ??
          (widget.onGenerateDarkTheme != null
              ? widget.onGenerateDarkTheme!(darkThemeData)
              : darkThemeData),
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

  ///初始化主题
  themeData({bool darkMode = false, Color? themeColor}) {
    ///dark状态darkMode 为系统darkMode
    ///userDarkMode为人为黑色主题
    var isDark = darkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    Color? themeColorAlpha = themeColor?.withOpacity(0.5);
    var themeData = ThemeData(
      // platform: TargetPlatform.windows,
      ///主题浅色或深色-
      brightness: brightness,
      primaryColorBrightness: brightness,

      ///强调色
      primaryColor: themeColor,
      errorColor: Colors.red,
      toggleableActiveColor: themeColor,
      colorScheme: ColorScheme.light(
        brightness: brightness,

        ///强调色
        primary: themeColor ?? Colors.blue,
        secondary: themeColor ?? const Color(0xff03dac6),
      ),

      ///输入框光标
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeColor,
        selectionColor: themeColorAlpha,
        selectionHandleColor: themeColorAlpha,
      ),

      ///指示器颜色--如TabBar
      indicatorColor: themeColor,

      ///[TextButton]
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: themeColor),
      ),

      ///[ElevatedButton]
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: themeColor),
      ),

      ///[OutlinedButton]
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(primary: themeColor),
      ),
    );
    themeData = themeData.copyWith(
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
      ),

      ///主题设置Appbar样式背景
      appBarTheme: themeData.appBarTheme.copyWith(
        ///根据主题设置Appbar样式背景
        color: themeData.cardColor,

        ///去掉海拔高度
        elevation: 0,

        ///titleText 样式--textTheme废弃
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : themeColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),

        ///action及leading Text样式 原body1废弃
        toolbarTextStyle: TextStyle(
          color: isDark ? Colors.white : themeColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        ///icon样式
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : themeColor,
        ),
      ),
      iconTheme: themeData.iconTheme.copyWith(
        color: themeColor,
      ),
      scaffoldBackgroundColor: themeData.cardColor,

      ///水波纹
      splashColor: themeColorAlpha,

      ///鼠标悬浮颜色
      hoverColor: themeColorAlpha,

      ///长按提示文本样式
      tooltipTheme: themeData.tooltipTheme.copyWith(
        textStyle: TextStyle(
          fontSize: 14,
          color: (isDark ? Colors.black : Colors.white).withOpacity(0.9),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
          top: 2,
        ),
        decoration: BoxDecoration(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.75),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
      ),

      bottomNavigationBarTheme: themeData.bottomNavigationBarTheme.copyWith(
        selectedItemColor: themeColor,
      ),

      ///TabBar样式设置
      tabBarTheme: themeData.tabBarTheme.copyWith(

          ///标签内边距
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),

          ///选中文字样式
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),

          ///未选择样式
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),

          ///指示器保持与label一致
          indicatorSize: TabBarIndicatorSize.label),

      ///floatingActionButton
      floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
        foregroundColor: themeColor,
        backgroundColor: themeData.cardColor,
        elevation: 10,
        splashColor: themeColorAlpha,
      ),

      ///dialog主题
      dialogTheme: const DialogTheme(),

      ///Divider分割线组件样式添加一个间隔线
      dividerTheme: DividerThemeData(
        ///线颜色
        color: themeData.hintColor.withOpacity(0.1),

        ///线粗细
        thickness: 0.7,

        ///前间隔
        indent: 0,

        ///后间隔
        endIndent: 0,
      ),

      ///全局获取焦点颜色--键盘/遥控器上下左右enter控制--目前还没弄清楚焦点处理逻辑
      focusColor: Colors.transparent,
    );
    return themeData;
  }
}
