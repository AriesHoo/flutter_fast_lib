import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///加载网页
class WebViewPage extends StatefulWidget {
  static start({
    required String initialUrl,
    BuildContext? context,
    String routeName = 'WebViewPage',
    bool fullscreenDialog = true,
  }) {
    Navigator.of(context ?? currentContext).push(
      CupertinoPageRoute(
        title: 'title',
        settings: RouteSettings(
          name: routeName,
        ),
        fullscreenDialog: fullscreenDialog,
        builder: (context) => WebViewPage(initialUrl: initialUrl),
      ),
    );
  }

  const WebViewPage({
    Key? key,
    required this.initialUrl,
  }) : super(key: key);
  final String initialUrl;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  ///控制器
  WebViewController? webViewController;

  ///当前标题
  String? currentTitle;

  ///网页标题
  final ValueNotifier<String> titleNotifier = ValueNotifier('Loading');

  ///可否返回
  static final ValueNotifier<bool> backNotifier = ValueNotifier(false);

  ///可否前进
  static final ValueNotifier<bool> goForwardNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: titleNotifier,
          builder: (context, str, _) => Text(str),
        ),
      ),
      body: FastWebView(
        initialUrl: widget.initialUrl,
        onPermissionRequest: (request) {
          FastToastUtil.showSuccess('${request.types}');
        },
        onWebViewCreated: (controller) {
          webViewController = controller;
        },

        ///进度变化
        onProgress: (progress) {
          ///获取当前网页标题
          _getWebTitle();
          if (progress >= 99) {
            _getProgressState();
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: backNotifier,
              builder: (context, value, child) => value
                  ? IconButton(
                      onPressed: () {
                        webViewController?.goBack();
                      },
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'back',
                    )
                  : const CloseButton(),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: goForwardNotifier,
              builder: (context, value, child) => IconButton(
                onPressed: value
                    ? () {
                        webViewController?.goForward();
                      }
                    : null,
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'forward',
              ),
            ),
            IconButton(
              onPressed: () {
                webViewController?.reload();
              },
              icon: const Icon(Icons.refresh),
              tooltip: 'refresh',
            ),
            IconButton(
              onPressed: () => FastToastUtil.show('share'),
              icon: const Icon(Icons.share),
              tooltip: 'share',
            ),
          ],
        ),
      ),
    );
  }

  ///获取网页标题
  void _getWebTitle() {
    webViewController?.getTitle().then((value) {
      FastLogUtil.e('title:$value');
      if (value != null && value.isNotEmpty && currentTitle != value) {
        currentTitle = value;
        titleNotifier.value = currentTitle!;
      }
    });
  }

  ///获取进度状态
  void _getProgressState() async {
    webViewController?.canGoBack().then((value) => backNotifier.value = value);
    webViewController
        ?.canGoForward()
        .then((value) => goForwardNotifier.value = value);
  }
}
