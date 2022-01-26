import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///网络检查工具-用于个人中心是否非Wi-Fi不观看及下载功能
class NetworkHelper {
  static NetworkHelper? _instance;

  factory NetworkHelper.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    _instance ??= NetworkHelper._internal();
    return _instance;
  }

  ///构造函数私有化，防止被误创建
  NetworkHelper._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ///网络监听器
  final List<Function(ConnectivityResult)> _listListener = [];

  ///当前网络情况
  ConnectivityResult? _connectivityResult;

  ///是否为手机网络
  bool get isMobile =>
      _connectivityResult != null &&
      _connectivityResult == ConnectivityResult.mobile;

  ///是否为Wi-Fi
  bool get isWifi =>
      _connectivityResult != null &&
      _connectivityResult == ConnectivityResult.wifi;

  ///是否连接以太网
  bool get ethernet =>
      _connectivityResult != null &&
      _connectivityResult == ConnectivityResult.ethernet;

  ///是否无网络链接
  bool get none =>
      _connectivityResult != null &&
      _connectivityResult == ConnectivityResult.none;

  ///是否连接网络--不代表当前应用有访问网络的权限(手机可单独禁用应用访问网络)
  bool get connectedNetwork => isWifi || isMobile || ethernet;

  ///返回当前网络情况
  Future<ConnectivityResult> checkConnectivity() {
    return _connectivity.checkConnectivity().then((value) {
      if (value != _connectivityResult) {
        for (var element in _listListener) {
          element.call(value);
        }
      }
      _connectivityResult = value;
      return value;
    });
  }

  ///添加网络监听
  NetworkHelper? addNetworkChangerListener(
      Function(ConnectivityResult)? listener) {
    if (listener != null && !_listListener.contains(listener)) {
      startListen();
      _listListener.add(listener);
    }
    return _instance;
  }

  ///移除网络监听
  NetworkHelper? removeNetworkChangerListener(
      Function(ConnectivityResult)? listener) {
    if (_listListener.contains(listener)) {
      _listListener.remove(listener);
    }
    return _instance;
  }

  ///开始网络监听
  startListen() {
    _connectivitySubscription ??= _connectivity.onConnectivityChanged.listen((event) {
        _connectivityResult = event;
        for (var element in _listListener) {
          element.call(event);
        }
      });

    ///当前网络状态为null--获取一次
    if (_connectivityResult == null) {
      checkConnectivity();
    }
  }

  ///结束网络监听
  disposeListen() {
    _listListener.clear();
    _connectivitySubscription?.cancel();
  }

  ///设置非wifi下播放
  Future<bool> setNotWifiEnable(bool enable) async {
    return await FastSpUtil.putBool('NotWifiEnable', enable)!;
  }

  ///获取是否非wifi下播放
  bool? getNotWifiEnable() {
    return FastSpUtil.getBool('NotWifiEnable', defValue: false);
  }
}
