import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_lib_init.dart';
import 'package:flutter_fast_lib/src/util/fast_loading_util.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_loading_state_widget.dart';

///[FastLoadingUtil] 默认参数配置及默认实现
mixin FastLoadingMixin {
  WrapAnimation? get loadingWrapAnimation => null;

  WrapAnimation? get loadingWrapLoadingAnimation => null;

  ///位置
  Alignment? get loadingAlign => Alignment.center;

  ///返回键[BackButtonBehavior]
  BackButtonBehavior? get loadingBackButtonBehavior => BackButtonBehavior.close;

  ///是否跨屏
  bool get loadingCrossPage => false;

  ///是否点击背景关闭
  bool get loadingClickClose => true;

  ///是否loading显示状态可点击背后widget
  bool get loadingAllowClick => false;

  ///键盘安全区域-避免键盘遮住
  bool get loadingEnableKeyboardSafeArea => true;

  bool get loadingIgnoreContentClick => true;

  ///关闭回调
  VoidCallback? get onLoadingClose => null;

  Duration? get loadingDuration => null;

  Duration? get loadingAnimationDuration => null;

  Duration? get loadingAnimationReverseDuration => null;

  ///背景蒙层
  Color get loadingBackgroundColor => Colors.black26;

  ///加载中loading-默认[loadingToastBuilder]
  Widget? get loadingWidget => null;

  ///加载中文本信息--默认[loadingToastBuilder]
  String? get loadingText => null;

  ///加载中文本信息样式--默认[loadingToastBuilder]
  TextStyle? get loadingTextStyle => null;

  ///视图builder
  Widget loadingWidgetBuilder(
      CancelFunc cancelFunc, Widget? loading, String? text, TextStyle? style) {
    text ??= loadingText;
    style ??= loadingTextStyle;
    loading ??= loadingWidget;
    return FastLoadingStateWidget(
      background: Theme.of(currentContext).cardColor,
      loading: loading,
      text: text != null
          ? Text(
              text,
              style: style,
            )
          : null,
    );
  }

  ///最终实现--单独重写以上默认配置即可高度定制化
  ///完全重写则可自己编辑loading逻辑--感觉没有必要
  showLoading({
    WrapAnimation? wrapAnimation,
    WrapAnimation? wrapLoadingAnimation,
    Alignment? align,
    BackButtonBehavior? backButtonBehavior,
    bool? crossPage,
    bool? clickClose,
    bool? allowClick,
    bool? enableKeyboardSafeArea,
    bool? ignoreContentClick,
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
    return BotToast.showCustomLoading(
      toastBuilder: builder ??
          (cancelFunc) =>
              loadingWidgetBuilder(cancelFunc, loading, text, textStyle),
      wrapAnimation: wrapAnimation ?? loadingWrapAnimation,
      wrapToastAnimation: wrapLoadingAnimation ?? loadingWrapLoadingAnimation,
      align: align ?? loadingAlign,
      enableKeyboardSafeArea:
          enableKeyboardSafeArea ?? loadingEnableKeyboardSafeArea,
      backButtonBehavior: backButtonBehavior ?? loadingBackButtonBehavior,
      clickClose: clickClose ?? loadingClickClose,
      allowClick: allowClick ?? loadingAllowClick,
      crossPage: crossPage ?? loadingCrossPage,
      ignoreContentClick: ignoreContentClick ?? loadingIgnoreContentClick,
      onClose: onClose ?? onLoadingClose,
      duration: duration ?? loadingDuration,
      animationDuration: animationDuration ?? loadingAnimationDuration,
      animationReverseDuration:
          animationReverseDuration ?? loadingAnimationReverseDuration,
      backgroundColor: backgroundColor ?? loadingBackgroundColor,
    );
  }
}
