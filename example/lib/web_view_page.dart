import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///打开网页
class WebViewPage extends FastWebViewPage {
  const WebViewPage({
    Key? key,
    required String initialUrl,
  }) : super(key: key, initialUrl: initialUrl);

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

  @override
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get floatingActionButtonBuilder => (context, controller) {
            return FutureBuilder<WebViewController>(
              future: controller,
              builder: (context, future) {
                return const SizedBox();
              },
            );
          };

  @override
  Widget Function(
          BuildContext context, Future<WebViewController> controllerFuture)?
      get bottomNavigationBarBuilder => (context, controller) {
            return FutureBuilder<WebViewController>(
              future: controller,
              builder: (context, future) {
                _canGoBack.value = false;
                _canGoForward.value = false;
                return SafeArea(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _canGoBack,
                        builder: (context, value, child) => value
                            ? IconButton(
                                onPressed:
                                    value ? () => future.data?.goBack() : null,
                                icon: const Icon(Icons.arrow_back),
                                tooltip: 'back',
                              )
                            : const CloseButton(),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _canGoForward,
                        builder: (context, value, child) => IconButton(
                          onPressed:
                              value ? () => future.data?.goForward() : null,
                          icon: const Icon(Icons.arrow_forward),
                          tooltip: 'forward',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          future.data?.reload();
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
                );
              },
            );
          };

  @override
  Function(int progress, WebViewController? controller) get onProgress =>
      (str, controller) async {
        if (controller == null) {
          return;
        }
        _canGoBack.value = await controller.canGoBack();
        _canGoForward.value = await controller.canGoForward();
      };

  ///可否返回
  static final ValueNotifier<bool> _canGoBack = ValueNotifier(false);

  ///可否前进
  static final ValueNotifier<bool> _canGoForward = ValueNotifier(false);
}
