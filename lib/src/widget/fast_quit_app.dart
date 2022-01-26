import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/mixin/fast_quit_app_mixin.dart';
import 'package:flutter_fast_lib/src/util/fast_platform_util.dart';

///常用Android主页面返回退出程序/退回桌面功能
///使用[WillPopScope]只对Android生效
class FastQuitApp extends StatelessWidget {
  const FastQuitApp({
    Key? key,
    required this.child,
    this.quitAppMixin,
  }) : super(key: key);

  ///拦截返回键--主要Android
  final FastQuitAppMixin? quitAppMixin;
  final Widget child;

  ///是否第一次点击返回键
  static bool _isFirstBack = true;

  @override
  Widget build(BuildContext context) {
    var quitMixin = quitAppMixin ?? FastManager.getInstance().quitAppMixin;
    return !FastPlatformUtil.isMobile
        ? child
        : WillPopScope(
            child: child,
            onWillPop: () async {
              int? delayBack = quitMixin.quitBack(_isFirstBack);

              ///获取延迟时间--时间为null或者=0则执行了quitMixin.quitBack操作
              ///重置状态
              if (delayBack == null || delayBack == 0) {
                _isFirstBack = true;
                return false;
              }
              if (!_isFirstBack) {
                quitMixin.quitBack(_isFirstBack);
              } else {
                _isFirstBack = false;
                Future.delayed(Duration(milliseconds: delayBack),
                    () => _isFirstBack = true);
              }
              return false;
            },
          );
  }
}
