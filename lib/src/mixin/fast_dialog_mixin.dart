import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///[FastDialog]参数默认配置
///1、2021-12-27 09:38 增加 内边距[contentPadding] 是否关闭按钮 [closable] 关闭按钮位置 [closeAlignment] 自定义关闭按钮[closeButton]
mixin FastDialogMixin {
  ///控制是否可滚动
  bool get scrollable => true;

  ///最小宽度
  double get minWidth => 280.0;

  ///最大宽度
  double get maxWidth => double.infinity;

  ///最大高度
  double get maxHeight => double.infinity;

  ///默认间隙
  EdgeInsets get defaultInsetPadding => EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQueryData.fromWindow(window).padding.bottom + 20,
        top: FastPlatformUtil.isMobile
            ? MediaQueryData.fromWindow(window).padding.top
            : 20,
      );

  ///默认Shape
  ShapeBorder get defaultDialogShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      );

  ///默认海拔
  double get defaultElevation => 24.0;

  ///阴影颜色
  Color? get shadowColor => Theme.of(currentContext).shadowColor;

  ///裁剪模式
  Clip get clipBehavior => Clip.hardEdge;

  ///默认内边距
  EdgeInsets? get defaultContentPadding => const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      );

  ///是否显示一个关闭按钮--web显示
  bool? get closable => kIsWeb;

  ///关闭按钮位置
  AlignmentGeometry? get closeAlignment => AlignmentDirectional.topEnd;

  ///关闭按钮
  Widget? get closeButton => IconButton(
        icon: const Icon(Icons.close),
        color: Theme.of(currentContext).colorScheme.primary,
        tooltip: closeButtonTooltip,
        onPressed: () => Navigator.maybePop(currentContext),
      );

  ///关闭按钮tooltip
  String get closeButtonTooltip => '关闭';
}
