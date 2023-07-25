import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///基础WebView--基于[WebViewWidget] 增加默认进度条
class FastWebView extends StatefulWidget {
  const FastWebView({
    super.key,
    required this.initialUrl,
    this.onPermissionRequest,
    this.onWebViewCreated,
    this.gestureRecognizers,
    this.onNavigationRequest,
    this.onProgress,
    this.progressBuilder,
  });

  ///需要加载url-网络地址
  final String initialUrl;

  ///WebView请求权限
  final void Function(WebViewPermissionRequest request)? onPermissionRequest;

  ///WebViewController 创建回调
  final void Function(WebViewController controller)? onWebViewCreated;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///可用于拦截是否加载url
  final NavigationRequestCallback? onNavigationRequest;

  ///网页加载进度-获取标题头
  final ProgressCallback? onProgress;

  ///完全自定义进度条
  final Widget Function(
    BuildContext context,
    int progress,
    WebViewController controller,
  )? progressBuilder;

  @override
  State<FastWebView> createState() => _FastWebViewState();
}

class _FastWebViewState extends State<FastWebView> {
  ///WebViewController
  late final WebViewController _controller;

  ///网页加载进度
  final ValueNotifier<int> _onProgress = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = WebViewController(
      onPermissionRequest: widget.onPermissionRequest,
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: widget.onNavigationRequest,

          ///加载完成
          onPageFinished: (url) {
            _onProgress.value = 100;
          },

          ///进度变化
          onProgress: (progress) {
            _onProgress.value = progress;

            ///回调进度
            widget.onProgress?.call(progress);
          },
        ),
      );

    ///创建成功回调
    widget.onWebViewCreated?.call(_controller);

    ///加载网页
    _controller.loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///顶部进度条
        ValueListenableBuilder<int>(
          valueListenable: _onProgress,
          builder: (context, progress, child) {
            Widget progressWidget =
                widget.progressBuilder?.call(context, progress, _controller) ??
                    SizedBox(
                      height: progress != 100 ? 2 : 0,
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                        value: progress / 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
            return progressWidget;
          },
        ),
        Expanded(
          child: WebViewWidget(
            controller: _controller,
            gestureRecognizers: widget.gestureRecognizers ??
                const <Factory<OneSequenceGestureRecognizer>>{},
          ),
        ),
      ],
    );
  }
}
