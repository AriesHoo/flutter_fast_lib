import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';

///Toast工具类-BotToast
class FastToastUtil {
  ///展示提示
  static show(
    String text, {
    AlignmentGeometry? align,
    Duration? duration,
    Color? backgroundColor,
    int? milliseconds,

    ///是否通知形式
    bool? notification,
  }) {
    FastManager.getInstance().toastMixin.show(
          text,
          align: align,
          duration: duration,
          backgroundColor: backgroundColor,
          milliseconds: milliseconds,
          notification: notification,
        );
  }

  ///成功
  static showSuccess(
    String text, {
    AlignmentGeometry? align,
    Duration? duration,

    ///是否通知形式
    bool? notification,
  }) {
    show(
      text,
      align: align,
      duration: duration,
      backgroundColor:
          FastManager.getInstance().toastMixin.successBackgroundColor,
      notification: notification,
    );
  }

  ///错误
  static showError(
    String text, {
    AlignmentGeometry? align,
    Duration? duration,
    bool? notification,
  }) {
    show(
      text,
      align: align,
      duration: duration,
      backgroundColor:
          FastManager.getInstance().toastMixin.errorBackgroundColor,
      notification: notification,
    );
  }

  ///提醒
  static showWarning(
    String text, {
    AlignmentGeometry? align,
    Duration? duration,

    ///是否通知形式
    bool? notification,
  }) {
    show(
      text,
      align: align,
      duration: duration,
      backgroundColor:
          FastManager.getInstance().toastMixin.warningBackgroundColor,
      notification: notification,
    );
  }
}
