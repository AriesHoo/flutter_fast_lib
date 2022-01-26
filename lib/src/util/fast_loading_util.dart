import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';

///基于[BotToast] showCustomLoading封装
///默认参数参看[FastLoadingMixin]
class FastLoadingUtil {
  ///展示loading
  static showLoading({
    WrapAnimation? wrapAnimation,
    WrapAnimation? wrapLoadingAnimation,
    Alignment? align,
    BackButtonBehavior? backButtonBehavior,
    bool? crossPage,
    bool? clickClose,
    bool? allowClick,
    bool? ignoreContentClick,
    bool? enableKeyboardSafeArea,
    VoidCallback? onClose,
    Duration? duration,
    Duration? animationDuration,
    Duration? animationReverseDuration,
    Color? backgroundColor,
    ToastBuilder? builder,
    Widget? loading,
    String? text,
    TextStyle? textStyle,
  }) {
    return FastManager.getInstance().loadingMixin.showLoading(
          wrapAnimation: wrapAnimation,
          wrapLoadingAnimation: wrapLoadingAnimation,
          align: align,
          enableKeyboardSafeArea: enableKeyboardSafeArea,
          backButtonBehavior: backButtonBehavior,
          clickClose: clickClose,
          allowClick: allowClick,
          crossPage: crossPage,
          ignoreContentClick: ignoreContentClick,
          onClose: onClose,
          duration: duration,
          animationDuration: animationDuration,
          animationReverseDuration: animationReverseDuration,
          backgroundColor: backgroundColor,
          builder: builder,
          loading: loading,
          text: text,
          textStyle: textStyle,
        );
  }

  ///隐藏Loading
  static hideLoading({CancelFunc? cancelFunc}) {
    if (cancelFunc != null) {
      cancelFunc.call();
      return;
    }
    BotToast.closeAllLoading();
  }
}
