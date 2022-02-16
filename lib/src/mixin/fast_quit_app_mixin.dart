
import 'package:flutter/cupertino.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///[FastMainPage]拦截退出App
///[FastTabBar]拦截退出App   --Android 系统行为
mixin FastQuitAppMixin {
  String get tipQuitApp => quitApp ? '再按一次退出程序' : '再按一次退回桌面';

  ///退出返回键--主要Android
  int? quitBack(bool firstBack) {
    bool canPop = Navigator.of(currentContext).canPop();

    FastLogUtil.e(
        'canPop:$canPop;currentContext:$currentContext;firstBack:$firstBack',
        tag: 'canPopTag');

    ///canPop说明非栈顶Router
    if (canPop) {
      Navigator.of(currentContext).pop();
      return null;
    }
    if (firstBack) {
      FastToastUtil.show(tipQuitApp,
          duration: Duration(
            milliseconds: delayTime ?? 2000,
          ));
    } else {
      ///Android退回系统桌面-进入后台
      if (quitApp) {
        exit(0);
      } else {
        FastMethodChannelUtil.navigateToSystemHome();
      }
    }
    return delayTime;
  }

  ///是否退出程序/回到系统桌面
  bool get quitApp => true;

  ///拦截超时阈值
  int? get delayTime => 2000;
}
