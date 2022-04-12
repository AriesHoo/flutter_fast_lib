import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_blood_belfry/constant/app_constant.dart';
import 'package:flutter_blood_belfry/util/app_util.dart';

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

///快速Dialog
class QuickDialog extends FastDialog {
  const QuickDialog({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? contentPadding,
    bool dismissible = true,
    bool closable = true,
    bool scrollable = false,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    double? aspectRatio,
  }) : super(
          key: key,
          child: child,
          contentPadding: contentPadding,
          dismissible: dismissible,
          closable: closable,
          scrollable: scrollable,
          maxWidth: maxHeight,
        );
}

///[IepDetailPage] 及[IepUserPage] 一级及二级dialog
class AppDialog extends FastDialog {
  final Widget _child;
  final double _maxWidth;
  final double _maxHeight;
  final double? aspectRatio;
  final bool _dismissible;
  final bool _closable;
  final bool _scrollable;
  final EdgeInsetsGeometry? _contentPadding;

  const AppDialog.width400({
    Key? key,
    required Widget child,
    bool dismissible = true,
    bool closable = true,
    EdgeInsetsGeometry? contentPadding,
    this.aspectRatio,
  })  : _maxWidth = 400,
        _maxHeight = double.infinity,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = true,
        _child = child,
        _contentPadding = contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 36,
            ),
        super(key: key);

  const AppDialog.height480x360({
    Key? key,
    required Widget child,
    this.aspectRatio = 3.0 / 4.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 360,
        _maxHeight = 480,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  const AppDialog.height640x480({
    Key? key,
    required Widget child,
    this.aspectRatio = 3.0 / 4.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 480,
        _maxHeight = 640,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  const AppDialog.height720x540({
    Key? key,
    required Widget child,
    this.aspectRatio = 3.0 / 4.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 540,
        _maxHeight = 720,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  const AppDialog.height960x720({
    Key? key,
    required Widget child,
    this.aspectRatio = 3.0 / 4.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 720,
        _maxHeight = 960,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  const AppDialog.width720x540({
    Key? key,
    required Widget child,
    this.aspectRatio = 4.0 / 3.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 720,
        _maxHeight = 540,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  const AppDialog.width960x720({
    Key? key,
    required Widget child,
    this.aspectRatio = 4.0 / 3.0,
    bool dismissible = true,
    bool closable = false,
    bool scrollable = false,
  })  : _maxWidth = 960,
        _maxHeight = 720,
        _dismissible = dismissible,
        _closable = closable,
        _scrollable = scrollable,
        _child = child,
        _contentPadding = null,
        super(key: key);

  bool get smallDisplay =>
      MediaQuery.of(currentContext).size.width <= _maxWidth;

  @override
  Widget? get child => smallDisplay
      ? _child
      : aspectRatio != null
          ? AspectRatio(
              aspectRatio: aspectRatio!,
              child: _child,
            )
          : _child;

  @override
  double? get maxHeight => smallDisplay ? double.infinity : _maxHeight;

  @override
  double? get maxWidth => smallDisplay ? double.infinity : _maxWidth;

  @override
  bool? get scrollable => _scrollable;

  @override
  bool? get closable => _closable;

  @override
  bool get dismissible => _dismissible;

  @override
  EdgeInsetsGeometry? get contentPadding => _contentPadding ?? EdgeInsets.zero;

  @override
  EdgeInsets? get insetPadding => EdgeInsets.only(
        left: smallDisplay ? 0 : 20,
        right: smallDisplay ? 0 : 20,
        bottom: smallDisplay
            ? 0
            : MediaQueryData.fromWindow(window).padding.bottom + 20,
        top: smallDisplay
            ? 0
            : FastPlatformUtil.isMobile
                ? MediaQueryData.fromWindow(window).padding.top
                : 20,
      );

  @override
  ShapeBorder? get shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(smallDisplay ? 0.0 : AppConstant.defaultRadius),
        ),
      );
}