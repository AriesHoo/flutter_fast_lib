import 'package:flutter/widgets.dart';
import 'package:flutter_blood_belfry/constant/app_constant.dart';
import 'package:flutter_blood_belfry/helper/app_helper.dart';
import 'package:flutter_blood_belfry/helper/user_helper.dart';
import 'package:flutter_blood_belfry/manager/route_manager.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:janalytics/janalytics.dart';

///统计帮助类
class AnalyticsHelper {
  static const String _tag = 'AnalyticsHelper';
  static AnalyticsHelper? _instance;

  factory AnalyticsHelper.getInstance() => _getInstance();
  static late Janalytics _analytics;
  static AnalyticsRouteObserver? _analyticsRouteObserver;

  ///是否上传
  static bool _upload = false;

  static bool get upload => _upload;

  ///设备品牌
  static String _brand = '';

  ///设备型号
  static String _model = '';

  ///系统名称
  static String _systemName = '';

  ///Android只是的abi架构
  static String _supportedAbi = '';

  ///是否统计页面
  static const bool _startPage = false;

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    if (_instance == null) {
      _instance = AnalyticsHelper._internal();
      _analytics = Janalytics();

      ///设置debug模式
      _analytics.setDebugMode(false);

      ///先停止上传Crash
      _analytics.stopCrashHandler();

      ///获取系统相关
      FastPlatformUtil.getBrand().then((value) => _brand = value.toUpperCase());
      FastPlatformUtil.getModel().then((value) => _model = value.toUpperCase());
      FastPlatformUtil.getSystemVersion().then((value) => _systemName = value);
      FastPlatformUtil.getSupportedAbi().then((value) => _supportedAbi =
          JsonUtil.encodeObj(value)!
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(',', '&'));

      ///物理机-真机才进行统计上报
      FastPlatformUtil.isPhysicalDevice().then((value) {
        ///真机才上报信息
        _upload = value;

        ///真机
        if (value) {
          ///设置debug模式
          _analytics.setDebugMode(AppConstant.isTest);

          ///开启错误日志上报
          _analytics.initCrashHandler();

          ///真机才进行初始化
          ///有极光key才进行初始化
          if (!TextUtil.isEmpty(AppConstant.jPushKey)) {
            _analytics.setup(
              appKey: AppConstant.jPushKey,
              channel: AppConstant.jPushChannel,
            );
          }
        }
      });
    }
    return _instance;
  }

  ///构造函数私有化，防止被误创建
  AnalyticsHelper._internal();

  ///路由监听
  AnalyticsRouteObserver? getAnalyticsRouteObserver() {
    _analyticsRouteObserver ??= AnalyticsRouteObserver();
    return _analyticsRouteObserver;
  }

  ///设置debug模式
  AnalyticsHelper? setDebugMode({bool debugMode = false}) {
    _analytics.setDebugMode(debugMode);
    return _instance;
  }

  ///进入页面
  AnalyticsHelper? onPageStart(String? pageName) {
    if (upload && _startPage) {
      _analytics.onPageStart(pageName!);
      FastLogUtil.v('onPageStart:$pageName', tag: _tag);

      ///进入主页面--注册用户
      if (RouteName.mainPage == pageName) {
        identifyAccount();
        onDeviceEvent();
      }
    }
    return _instance;
  }

  ///离开页面
  AnalyticsHelper? onPageEnd(String? pageName) {
    if (upload && _startPage) {
      _analytics.onPageEnd(pageName!);
      FastLogUtil.v('onPageEnd:$pageName', tag: _tag);

      ///离开主页面--注销用户
      if (RouteName.mainPage == pageName) {
        detachAccount();
      }
    }
    return _instance;
  }

  ///登记账户信息
  Future<Map<dynamic, dynamic>>? identifyAccount() {
    if (upload && UserHelper.isLogin) {
      return _analytics
          .identifyAccount(
        '${UserHelper.userId}',
        name: UserHelper.accountName,
        sex: UserHelper.female ? 2 : 1,
        // extMap: _addAnalyticsExtMap(
        //   extMap: {
        //     'institutionName': UserHelper.institutionName,
        //     'isViewByOthers': '${UserHelper.searchByOthers}',
        //     'passwordCheck': '${UserHelper.passwordCheck()}'
        //   },
        // ),
      )
          .then((value) {
        FastLogUtil.v('identifyAccount-callback:${JsonUtil.encodeObj(value)}',
            tag: _tag);
        return value!;
      });
    }
    return null;
  }

  ///注销登记账户信息
  Future<Map<dynamic, dynamic>> detachAccount() {
    return _analytics.detachAccount().then((value) {
      FastLogUtil.v('detachAccount-callback:${JsonUtil.encodeObj(value)}',
          tag: _tag);
      return value!;
    });
  }

  ///错误日志
  AnalyticsHelper? reportError(
    String error, {
    int? errorCode,
    Map<String, String>? extMap,
  }) {
    if (TextUtil.isEmpty(error) || !UserHelper.isLogin || !upload) {
      return _instance;
    }
    extMap = _addAnalyticsExtMap(extMap: extMap);
    extMap.putIfAbsent('error', () => error);
    String eventId =
        errorCode != null ? 'errorReport_$errorCode' : 'errorReport';
    _analytics.onCountEvent(
      eventId,
      extMap: extMap,
    );
    FastLogUtil.v(
      'reportError-errorCode:$errorCode;eventId:$eventId;extMap:${JsonUtil.encodeObj(extMap)}',
      tag: _tag,
    );
    return _instance;
  }

  ///浏览事件
  AnalyticsHelper? onBrowseEvent({
    String? browseId,
    String? browseName,
    String? browseType,
    int? browseDuration,
    Map<String, String>? extMap,
  }) {
    if (!UserHelper.isLogin || !upload) {
      return _instance;
    }
    extMap = _addAnalyticsExtMap(extMap: extMap);
    _analytics.onBrowseEvent(
      browseId!,
      browseName!,
      browseType!,
      browseDuration!,
      extMap: extMap,
    );
    return _instance;
  }

  ///登录事件
  AnalyticsHelper? onLoginEvent() {
    if (!upload) {
      return _instance;
    }
    String loginWay = 'normal';
    switch (HeaderHelper.singleton.getLoginType()) {
      case 1:
        loginWay = 'admin';
        break;
      case 2:
        loginWay = 'normal';
        break;
      case 3:
        loginWay = 'visitor';
        break;
    }
    _analytics.onLoginEvent(
      loginWay,
      true,
      extMap: _addAnalyticsExtMap(),
    );
    return _instance;
  }

  ///激活事件
  AnalyticsHelper? onRegisterEvent(
    bool registerSuccess,
    String idCard,
    String name,
    String? phone,
  ) {
    if (!upload) {
      return _instance;
    }
    _analytics.onRegisterEvent(
      'checkActivate',
      registerSuccess,
      extMap: _addAnalyticsExtMap(
        extMap: {
          'idCard': TextUtil.hideNumber(idCard,
              start: 3, end: 15, replacement: '************'),
          'name': name,
          'phone': TextUtil.hideNumber(phone!),
        },
      ),
    );
    return _instance;
  }

  ///统计使用设备数量
  onDeviceEvent() async {
    if (_isDeviceAnalytics()! || !upload) {
      return;
    }
    _analytics.onCalculateEvent(
      FastPlatformUtil.operatingSystem.toUpperCase(),
      1,
      extMap: _addAnalyticsExtMap(
        userInfo: false,
        operatingSystem: false,
      ),
    );
    _setDeviceAnalytics();
  }

  ///增加统计额外信息--用户信息-设备信息
  Map<String, String> _addAnalyticsExtMap({
    Map<String, String>? extMap,
    bool userInfo = true,
    bool systemInfo = true,
    bool operatingSystem = true,
  }) {
    extMap = extMap ?? {};

    ///登录过
    // if (userInfo && UserHelper.isLogin) {
    //   if (!extMap.containsKey('userId')) {
    //     extMap.putIfAbsent('userId', () => '${UserHelper.userId}');
    //   }
    //   if (!extMap.containsKey('userName')) {
    //     extMap.putIfAbsent('userName', () => UserHelper.accountName);
    //   }
    //   if (!extMap.containsKey('institutionName')) {
    //     extMap.putIfAbsent(
    //         'institutionName', () => UserHelper.institutionName);
    //   }
    // }

    ///系统信息
    if (systemInfo) {
      if (!extMap.containsKey('brand') && !TextUtil.isEmpty(_brand)) {
        extMap.putIfAbsent('brand', () => _brand);
      }
      if (!extMap.containsKey('model') && !TextUtil.isEmpty(_model)) {
        extMap.putIfAbsent('model', () => _model);
      }
      if (!extMap.containsKey('systemName') && !TextUtil.isEmpty(_systemName)) {
        extMap.putIfAbsent('systemName', () => _systemName);
      }
      if (!extMap.containsKey('supportedAbi') &&
          !TextUtil.isEmpty(_supportedAbi)) {
        extMap.putIfAbsent('supportedAbi', () => _supportedAbi);
      }

      ///所在系统
      if (operatingSystem) {
        if (!extMap.containsKey('operatingSystem')) {
          extMap.putIfAbsent(
              'operatingSystem', () => FastPlatformUtil.operatingSystem);
        }
      }
    }
    FastLogUtil.v('addAnalyticsExtMap:${JsonUtil.encodeObj(extMap)}',
        tag: _tag);
    return extMap;
  }

  ///是否已统计过设备
  bool? _isDeviceAnalytics() {
    return FastSpUtil.getBool('IsDeviceAnalytics', defValue: false);
  }

  ///设置设置统计状态
  _setDeviceAnalytics() {
    FastSpUtil.putBool('IsDeviceAnalytics', true);
  }
}

///应用路由监听
class AnalyticsRouteObserver<R extends Route<dynamic>>
    extends RouteObserver<R> {

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    if (!TextUtil.isEmpty(route.settings.name)) {
      AnalyticsHelper.getInstance().onPageStart(route.settings.name);
    }
    if (!TextUtil.isEmpty(previousRoute?.settings.name)) {
      AnalyticsHelper.getInstance().onPageEnd(previousRoute?.settings.name);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (!TextUtil.isEmpty(route.settings.name)) {
      AnalyticsHelper.getInstance().onPageEnd(route.settings.name);
    }
    if (!TextUtil.isEmpty(previousRoute?.settings.name)) {
      AnalyticsHelper.getInstance().onPageStart(previousRoute!.settings.name);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (!TextUtil.isEmpty(newRoute?.settings.name)) {
      AnalyticsHelper.getInstance().onPageStart(newRoute!.settings.name);
    }
    if (!TextUtil.isEmpty(oldRoute?.settings.name)) {
      AnalyticsHelper.getInstance().onPageEnd(oldRoute!.settings.name);
    }
  }
}
