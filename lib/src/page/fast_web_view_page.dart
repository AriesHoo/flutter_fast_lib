import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/util/fast_platform_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///WebView加载网页封装
class FastWebViewPage extends StatefulWidget {
  const FastWebViewPage({
    Key? key,
    this.initialUrl = '',
    this.onWebViewCreated,
    this.navigationDelegate,
    this.onPageStarted,
    this.onPageFinished,
    this.onProgress,
    this.showAppBar = true,
    this.toolbarHeight,
    this.flexibleSpace,
    this.backgroundColor,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.systemOverlayStyle,
    this.title,
    this.loadingTitle = 'Loading...',
    this.titleBuilder,
    this.leadingBuilder,
    this.actionsBuilder,
    this.floatingActionButtonBuilder,
    this.bottomNavigationBarBuilder,
  }) : super(key: key);

  final String initialUrl;
  final WebViewCreatedCallback? onWebViewCreated;
  final NavigationDelegate? navigationDelegate;
  final PageStartedCallback? onPageStarted;
  final PageFinishedCallback? onPageFinished;
  final Function(int progress, WebViewController? controller)? onProgress;

  ///是否显示AppBar
  final bool showAppBar;
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final TextStyle? toolbarTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final SystemUiOverlayStyle? systemOverlayStyle;

  ///标题--不为空则直接显示
  final String? title;
  final String? loadingTitle;

  ///title 自定义
  final Widget Function(
          BuildContext context, String title, WebViewController controller)?
      titleBuilder;

  ///leading自定义
  final Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      leadingBuilder;

  ///action自定义
  final List<Widget> Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      actionsBuilder;

  ///floatingActionButton自定义
  final Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      floatingActionButtonBuilder;

  ///bottomNavigationBar自定义
  final Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      bottomNavigationBarBuilder;

  @override
  _FastWebViewPageState createState() => _FastWebViewPageState();
}

class _FastWebViewPageState extends State<FastWebViewPage> {
  ///网页标题
  final ValueNotifier<String> _onTitle = ValueNotifier('');

  ///控制器
  WebViewController? _webViewController;

  ///WebViewController Completer
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  ///title 自定义
  Widget Function(
          BuildContext context, String title, WebViewController controller)?
      _titleBuilder;

  ///leading自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      _leadingBuilder;

  ///action自定义
  List<Widget> Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      _actionsBuilder;

  ///floatingActionButton自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      _floatingActionButtonBuilder;

  ///bottomNavigationBar自定义
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      _bottomNavigationBarBuilder;

  @override
  void initState() {
    super.initState();

    ///无固定title则显示loadingTitle
    _onTitle.value = widget.title ??
        widget.loadingTitle ??
        FastManager.getInstance().webViewMixin.webLoadingTitle;
    _titleBuilder = widget.titleBuilder ??
        FastManager.getInstance().webViewMixin.webTitleBuilder;
    _leadingBuilder = widget.leadingBuilder ??
        FastManager.getInstance().webViewMixin.webLeadingBuilder;
    _actionsBuilder = widget.actionsBuilder ??
        FastManager.getInstance().webViewMixin.webActionsBuilder;
    _floatingActionButtonBuilder = widget.floatingActionButtonBuilder ??
        FastManager.getInstance().webViewMixin.webFloatingActionButtonBuilder;
    _bottomNavigationBarBuilder = widget.bottomNavigationBarBuilder ??
        FastManager.getInstance().webViewMixin.webBottomNavigationBarBuilder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              toolbarHeight: widget.toolbarHeight,
              flexibleSpace: widget.flexibleSpace,
              backgroundColor: widget.backgroundColor,
              leading: _leadingBuilder != null
                  ? _leadingBuilder!(context, _controllerCompleter.future)
                  : null,
              title: ValueListenableBuilder<String>(
                valueListenable: _onTitle,
                builder: (context, value, child) => _titleBuilder != null
                    ? _titleBuilder!(context, value, _webViewController!)
                    : Text(value),
              ),
              actions: _actionsBuilder != null
                  ? _actionsBuilder!(context, _controllerCompleter.future)
                  : null,
              titleTextStyle: widget.titleTextStyle,
              toolbarTextStyle: widget.toolbarTextStyle,
              iconTheme: widget.iconTheme,
              actionsIconTheme: widget.actionsIconTheme,
              systemOverlayStyle: widget.systemOverlayStyle,
            )
          : null,
      body: FastWebView(
        initialUrl: widget.initialUrl,
        navigationDelegate: widget.navigationDelegate,
        onWebViewCreated: (controller) {
          _webViewController = controller;
          _controllerCompleter.complete(controller);
          if (widget.onWebViewCreated != null) {
            widget.onWebViewCreated!.call(controller);
          }
        },
        onPageStarted: widget.onPageStarted,
        onPageFinished: widget.onPageFinished,
        onProgress: (progress) {
          _getTitle();
          widget.onProgress?.call(progress, _webViewController);
        },
      ),
      floatingActionButton: _floatingActionButtonBuilder != null
          ? _floatingActionButtonBuilder!(context, _controllerCompleter.future)
          : null,
      bottomNavigationBar: _bottomNavigationBarBuilder != null
          ? _bottomNavigationBarBuilder!(context, _controllerCompleter.future)
          : null,
    );
  }

  ///获取标题
  _getTitle() {
    if (_webViewController == null || !widget.showAppBar) {
      return;
    }
    _webViewController!.getTitle().then((value) {
      if (!TextUtil.isEmpty(value)) {
        _onTitle.value = value!;
      }
    });
  }
}

///基础WebView--基于[WebView] 增加默认进度条
///默认配置通过[FastWebViewMixin]
class FastWebView extends StatefulWidget {
  const FastWebView({
    Key? key,
    required this.initialUrl,
    this.onWebViewCreated,
    this.javascriptMode,
    this.javascriptChannels,
    this.navigationDelegate,
    this.gestureRecognizers,
    this.onPageStarted,
    this.onPageFinished,
    this.onProgress,
    this.onWebResourceError,
    this.debuggingEnabled,
    this.gestureNavigationEnabled,
    this.userAgent,
    this.initialMediaPlaybackPolicy,
    this.allowsInlineMediaPlayback,
    this.progressHeight,
    this.progressColor,
    this.progressBackgroundColor,
    this.progressValueColor,
    this.progressBuilder,
  }) : super(key: key);

  final String? initialUrl;
  final WebViewCreatedCallback? onWebViewCreated;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;
  final JavascriptMode? javascriptMode;
  final Set<JavascriptChannel>? javascriptChannels;
  final NavigationDelegate? navigationDelegate;
  final bool? allowsInlineMediaPlayback;
  final PageStartedCallback? onPageStarted;
  final PageFinishedCallback? onPageFinished;
  final PageLoadingCallback? onProgress;
  final WebResourceErrorCallback? onWebResourceError;
  final bool? debuggingEnabled;
  final bool? gestureNavigationEnabled;
  final String? userAgent;
  final AutoMediaPlaybackPolicy? initialMediaPlaybackPolicy;

  ///进度条高度
  final double? progressHeight;
  final Color? progressColor;
  final Color? progressBackgroundColor;

  ///进度条颜色
  final Animation<Color?>? progressValueColor;

  ///进度条完全自定义
  final Widget Function(
          BuildContext context, int progress, WebViewController controller)?
      progressBuilder;

  @override
  _FastWebViewState createState() => _FastWebViewState();
}

class _FastWebViewState extends State<FastWebView> {
  ///网页加载进度
  final ValueNotifier<int> _onProgress = ValueNotifier(0);

  ///WebViewController
  WebViewController? _webViewController;

  ///完全自定义进度条
  Widget Function(
          BuildContext context, int progress, WebViewController controller)?
      _progressBuilder;

  @override
  void initState() {
    super.initState();
    _progressBuilder ??= FastManager.getInstance().webViewMixin.progressBuilder;

    ///Android环境
    if (FastPlatformUtil.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: _onProgress,
          builder: (context, progress, child) {
            return _progressBuilder == null
                ? SizedBox(
                    height: progress != 100
                        ? widget.progressHeight ??
                            FastManager.getInstance()
                                .webViewMixin
                                .progressHeight
                        : 0,
                    child: LinearProgressIndicator(
                      backgroundColor: widget.progressBackgroundColor ??
                          FastManager.getInstance()
                              .webViewMixin
                              .progressBackgroundColor,
                      value: progress / 100,
                      color: widget.progressColor ??
                          FastManager.getInstance().webViewMixin.progressColor,
                      valueColor: widget.progressValueColor ??
                          FastManager.getInstance()
                              .webViewMixin
                              .progressValueColor,
                    ),
                  )
                : _progressBuilder!(context, progress, _webViewController!);
          },
        ),
        Expanded(
          child: WebView(
            initialUrl: widget.initialUrl,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              if (widget.onWebViewCreated != null) {
                widget.onWebViewCreated!.call(controller);
              }
            },
            javascriptMode: widget.javascriptMode ??
                FastManager.getInstance().webViewMixin.javascriptMode,
            javascriptChannels: widget.javascriptChannels ??
                FastManager.getInstance().webViewMixin.javascriptChannels,
            navigationDelegate: widget.navigationDelegate ??
                FastManager.getInstance().webViewMixin.navigationDelegate,
            gestureRecognizers: widget.gestureRecognizers,
            onPageStarted: (str) {
              if (widget.onPageStarted != null) {
                widget.onPageStarted!.call(str);
              }
              if (FastManager.getInstance().webViewMixin.onWebPageStarted !=
                  null) {
                FastManager.getInstance()
                    .webViewMixin
                    .onWebPageStarted!
                    .call(str, _webViewController);
              }
            },
            onPageFinished: (str) {
              _onProgress.value = 100;
              if (widget.onPageFinished != null) {
                widget.onPageFinished!.call(str);
              }
              if (FastManager.getInstance().webViewMixin.onWebPageFinished !=
                  null) {
                FastManager.getInstance()
                    .webViewMixin
                    .onWebPageFinished!
                    .call(str, _webViewController);
              }
            },
            onProgress: (progress) {
              _onProgress.value = progress;
              if (widget.onProgress != null) {
                widget.onProgress!.call(progress);
              }
              if (FastManager.getInstance().webViewMixin.onWebProgress !=
                  null) {
                FastManager.getInstance()
                    .webViewMixin
                    .onWebProgress!
                    .call(progress, _webViewController);
              }
            },
            onWebResourceError: (error) {
              ///错误也返回进度为100--毕竟已经做完了相关加载操作
              _onProgress.value = 100;
              if (widget.onWebResourceError != null) {
                widget.onWebResourceError!.call(error);
              }
            },
            debuggingEnabled: widget.debuggingEnabled ??
                FastManager.getInstance().webViewMixin.debuggingEnabled,
            gestureNavigationEnabled: widget.gestureNavigationEnabled ??
                FastManager.getInstance().webViewMixin.gestureNavigationEnabled,
            userAgent: widget.userAgent ??
                FastManager.getInstance().webViewMixin.userAgent,
            initialMediaPlaybackPolicy: widget.initialMediaPlaybackPolicy ??
                FastManager.getInstance()
                    .webViewMixin
                    .initialMediaPlaybackPolicy,
            allowsInlineMediaPlayback: widget.allowsInlineMediaPlayback ??
                FastManager.getInstance()
                    .webViewMixin
                    .allowsInlineMediaPlayback,
          ),
          flex: 1,
        )
      ],
    );
  }
}
