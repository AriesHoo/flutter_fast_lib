import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../fast_lib_init.dart';

///[FastWebView]默认属性配置
///来源[WebView]
mixin FastWebViewMixin {
  ///是否允许加载js--默认禁止
  JavascriptMode get javascriptMode => JavascriptMode.unrestricted;

  Set<JavascriptChannel>? get javascriptChannels => null;

  ///导航控制--点击某个url内链接
  ///[NavigationDecision.navigate]--继续跳转
  ///[NavigationDecision.prevent]--不做跳转
  NavigationDelegate? get navigationDelegate => null;

  ///是否启用原生WebView debug调试模式
  bool get debuggingEnabled => false;

  /// A Boolean value indicating whether horizontal swipe gestures will trigger back-forward list navigations.
  /// This only works on iOS.
  /// By default `gestureNavigationEnabled` is false.
  ///一个布尔值，指示水平滑动手势是否会触发前向列表导航。
  ///这只适用于iOS。
  ///默认情况下，“gestureNavigationEnabled”为false。
  bool get gestureNavigationEnabled => false;

  String? get userAgent => null;

  /// Which restrictions apply on automatic media playback.
  /// This initial value is applied to the platform's webview upon creation. Any following
  /// changes to this parameter are ignored (as long as the state of the [WebView] is preserved).
  /// The default policy is [AutoMediaPlaybackPolicy.require_user_action_for_all_media_types].
  ///哪些限制适用于自动媒体播放。
  ///此初始值在创建时应用于平台的webView。任何追随者
  ///对该参数的更改将被忽略（只要[WebView]的状态保持不变）。
  ///默认策略为[AutoMediaPlaybackPolicy.require_user_action_for_all_media_types]。
  AutoMediaPlaybackPolicy get initialMediaPlaybackPolicy =>
      AutoMediaPlaybackPolicy.require_user_action_for_all_media_types;

  /// Controls whether inline playback of HTML5 videos is allowed on iOS.
  /// This field is ignored on Android because Android allows it by default.
  /// By default `allowsInlineMediaPlayback` is false.
  ///控制是否允许在iOS上在线播放HTML5视频。
  ///此字段在Android上被忽略，因为Android默认允许此字段。
  ///默认情况下，“allowsInlineMediaPlayback”为false。
  bool get allowsInlineMediaPlayback => false;

  ///页面加载开始
  Function(String str, WebViewController? controller)? get onWebPageStarted =>
      null;

  ///页面加载进度
  Function(int progress, WebViewController? controller)? get onWebProgress =>
      null;

  ///页面加载完成
  Function(String str, WebViewController? controller)? get onWebPageFinished =>
      null;

  ///进度条高度
  double get progressHeight => 2;

  Color? get progressColor => Theme.of(currentContext).colorScheme.primary;

  Color? get progressBackgroundColor => Theme.of(currentContext).colorScheme.primary.withOpacity(0.4);

  ///进度条颜色
  Animation<Color?>? get progressValueColor => null;

  ///进度条完全自定义
  Widget Function(
          BuildContext context, int progress, WebViewController controller)?
      get progressBuilder => null;

  ///以下为[FastWebViewPage]属性
  ///加载中标题提示
  String get webLoadingTitle => 'Loading...';

  ///title 自定义
  Widget Function(
          BuildContext context, String title, WebViewController controller)?
      get webTitleBuilder => null;

  ///leading自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get webLeadingBuilder => null;

  ///action自定义
  List<Widget> Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get webActionsBuilder => null;

  ///floatingActionButton自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get webFloatingActionButtonBuilder => null;

  ///bottomNavigationBar自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get webBottomNavigationBarBuilder => null;
}
