import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';

///[FastToastUtil] Toast工具类配置及实现
mixin FastToastMixin {
  ///顶部通知栏模式
  bool get notification => true;

  ///独一份
  bool get toastOnlyOne => true;

  ///跨页面
  bool get toastCrossPage => true;

  ///背景色-默认
  Color get toastBackgroundColor => Colors.black.withOpacity(0.75);

  ///背景色-[FastToastUtil][showSuccess(text)]
  Color get successBackgroundColor => Colors.green.withOpacity(0.75);

  ///背景色-[FastToastUtil][showError(text)]
  Color get errorBackgroundColor => Colors.red.withOpacity(0.75);

  ///背景色-[FastToastUtil][showWarning(text)]
  Color get warningBackgroundColor => Colors.amber.withOpacity(0.75);

  ///圆角
  double get toastBorderRadius => 6;

  ///Toast位置
  AlignmentGeometry toastAlign(bool? notify) {
    notify ??= notification;
    return notify ? const Alignment(0, -0.99) : const Alignment(0, 0.8);
  }

  ///键盘安全区域-避免键盘遮住
  bool get toastEnableKeyboardSafeArea => true;

  ///展示toast
  show(
    String text, {
    AlignmentGeometry? align,
    Duration? duration,
    Color? backgroundColor,
    int? milliseconds,

    ///是否通知形式
    bool? notification,
  }) {
    notification ??= FastManager.getInstance().toastMixin.notification;
    align ??= toastAlign(notification);
    duration ??= Duration(
      milliseconds: milliseconds ?? (text.length > 10 ? 5000 : 2500),
    );
    notification
        ? BotToast.showSimpleNotification(
            align: align is Alignment ? align : null,
            title: text,
            titleStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            hideCloseButton: true,
            animationDuration: const Duration(milliseconds: 600),
            backgroundColor: backgroundColor ?? toastBackgroundColor,
            borderRadius: toastBorderRadius,
            duration: duration,

            ///只显示一个
            onlyOne: toastOnlyOne,
            crossPage: toastCrossPage,
            enableKeyboardSafeArea: toastEnableKeyboardSafeArea,
          )
        : BotToast.showText(
            text: text,
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            align: align,
            backgroundColor: Colors.transparent,
            contentColor: backgroundColor ?? toastBackgroundColor,
            borderRadius: BorderRadius.circular(toastBorderRadius),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            duration: duration,

            ///只显示一个
            onlyOne: toastOnlyOne,
            crossPage: toastCrossPage,
            enableKeyboardSafeArea: toastEnableKeyboardSafeArea,
          );
  }
}
