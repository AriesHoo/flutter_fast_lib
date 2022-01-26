import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';

///通用底部Dialog
class BottomDialog extends FastDialog {
  final Widget bottom;
  final double? dialogMaxWidth;

  const BottomDialog({
    Key? key,
    required this.bottom,
    this.dialogMaxWidth,
    EdgeInsetsGeometry? contentPadding,
  }) : super(
          key: key,
          child: bottom,
          contentPadding: contentPadding,
        );

  @override
  double get maxWidth =>
      dialogMaxWidth ?? (isSmallDisplay ? double.infinity : 420);

  @override
  double? get elevation => 0;

  @override
  EdgeInsets? get insetPadding => isSmallDisplay && dialogMaxWidth == null
      ? EdgeInsets.only(
          top: FastPlatformUtil.isMobile
              ? MediaQueryData.fromWindow(window).padding.top
              : 20,
        )
      : super.insetPadding;

  @override
  ShapeBorder? get shape => RoundedRectangleBorder(
        borderRadius: isSmallDisplay && dialogMaxWidth == null
            ? const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : BorderRadius.circular(12),
      );

  @override
  AlignmentGeometry get alignment => isSmallDisplay && dialogMaxWidth == null
      ? runOniOS
          ? Alignment.center
          : Alignment.centerRight
      : runOniOS
          ? Alignment.center
          : Alignment.bottomRight;
}
