import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib/src/mixin/default_fast_lib_mixin.dart';

///内部设置暴露给开发者统一属性设置入口
class FastManager {
  static FastManager? _instance;

  factory FastManager.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    _instance ??= FastManager._internal();
    return _instance;
  }

  ///构造函数私有化，防止被误创建
  FastManager._internal();

  FastNetworkMixin _networkMixin = defaultFastLibMixin;

  FastNetworkMixin get networkMixin => _networkMixin;

  FastRefreshListMixin _refreshListMixin = defaultFastLibMixin;

  FastRefreshListMixin get refreshListMixin => _refreshListMixin;

  FastTextMixin _textMixin = defaultFastLibMixin;

  FastTextMixin get textMixin => _textMixin;

  FastQuitAppMixin _quitAppMixin = defaultFastLibMixin;

  FastQuitAppMixin get quitAppMixin => _quitAppMixin;

  FastAdaptiveMixin _adaptiveMixin = defaultFastLibMixin;

  FastAdaptiveMixin get adaptiveMixin => _adaptiveMixin;

  FastDialogMixin _dialogMixin = defaultFastLibMixin;

  FastDialogMixin get dialogMixin => _dialogMixin;

  FastLogMixin _logMixin = defaultFastLibMixin;

  FastLogMixin get logMixin => _logMixin;

  FastToastMixin _toastMixin = defaultFastLibMixin;

  FastToastMixin get toastMixin => _toastMixin;

  FastLoadingMixin _loadingMixin = defaultFastLibMixin;

  FastLoadingMixin get loadingMixin => _loadingMixin;
  FastWebViewMixin _webViewMixin = defaultFastLibMixin;

  FastWebViewMixin get webViewMixin => _webViewMixin;

  ///设置各个Mixin实例
  ///[DefaultFastLibMixin]可设置全部默认项-按需设置
  FastManager setMixin({
    DefaultFastLibMixin? defaultMixin,
    FastNetworkMixin? networkMixin,
    FastRefreshListMixin? refreshListMixin,
    FastTextMixin? textMixin,
    FastQuitAppMixin? quitAppMixin,
    FastAdaptiveMixin? adaptiveMixin,
    FastDialogMixin? dialogMixin,
    FastLogMixin? logMixin,
    FastToastMixin? toastMixin,
    FastLoadingMixin? loadingMixin,
    FastWebViewMixin? webViewMixin,
  }) {
    ///设置默认项目
    if (defaultMixin != null) {
      defaultFastLibMixin = defaultMixin;
    }
    _networkMixin = networkMixin ?? defaultFastLibMixin;
    _refreshListMixin = refreshListMixin ?? defaultFastLibMixin;
    _textMixin = textMixin ?? defaultFastLibMixin;
    _quitAppMixin = quitAppMixin ?? defaultFastLibMixin;
    _adaptiveMixin = adaptiveMixin ?? defaultFastLibMixin;
    _dialogMixin = dialogMixin ?? defaultFastLibMixin;
    _logMixin = logMixin ?? defaultFastLibMixin;
    _toastMixin = toastMixin ?? defaultFastLibMixin;
    _loadingMixin = loadingMixin ?? defaultFastLibMixin;
    _webViewMixin = webViewMixin ?? defaultFastLibMixin;
    return _getInstance();
  }
}
