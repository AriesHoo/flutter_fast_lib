import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:url_launcher/url_launcher.dart';

FastLibMixin fastLibMixin = FastLibMixin();

///FastLib 默认配置管理--方便修改部分数据
///[FastManager]
class FastLibMixin extends DefaultFastLibMixin {
  @override
  String get tag => 'FastLibExample';

  @override
  NavigationDelegate? get navigationDelegate =>
      (NavigationRequest navigation) async {
        FastLogUtil.d('message:${navigation.url}',
            tag: 'NavigationDelegateTag');

        ///下载知乎-apple store
        if (!navigation.url.startsWith('http') &&
            navigation.url.contains('://')) {
          if (await canLaunch(navigation.url)) {
            int? position = await showDialog(
              context: currentContext,
              builder: (context) => AlertDialog(
                title: const Text(
                  '温馨提示',
                  // style: TextStyle(
                  //   color: Colors.red,
                  // ),
                ),
                content: const Text('即将跳转打开其它应用,是否打开?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(0),
                      child: const Text('取消')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(1),
                      child: const Text('打开'))
                ],
              ),
            );
            if (position == 1) {
              launch(navigation.url);
            }
          } else {
            FastToastUtil.showError('系统无法打开该网址');
          }
          return NavigationDecision.prevent;
        }

        ///正常http或https打头链接
        FastLogUtil.d('isForMainFrame:${navigation.isForMainFrame}',
            tag: 'NavigationDelegateTag');
        return NavigationDecision.navigate;
      };
}
