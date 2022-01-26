import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/enum/fast_platform_type.dart';
import 'package:flutter_fast_lib/src/fast_lib_init.dart';

///dialog提示-AlertDialog
///
class FastDialogUtil {
  /// 弹出对话框
  static Future<int?> showAlertDialog({
    BuildContext? context,
    String? title,
    Color? titleColor,
    Widget? titleWidget,
    String? content,
    Color? contentColor,
    Widget? contentWidget,
    String? cancel,
    Color? cancelColor,
    Widget? cancelWidget,
    String? ensure,
    Color? ensureColor,
    Widget? ensureWidget,
    List<Widget>? actions,
    VoidCallback? onCancelPressed,
    VoidCallback? onEnsurePressed,
    FastPlatformType? platformType,
    String? barrierLabel,
    bool useRootNavigator = true,
    bool barrierDismissible = true,
    RouteSettings? routeSettings,
    Color? barrierColor = Colors.black54,
    bool useSafeArea = true,
  }) async {
    BuildContext _context = context ?? currentContext;

    ///默认与当前TargetPlatform保持一致
    TargetPlatform _platform = Theme.of(_context).platform;

    ///初步确定是否为Cupertino样式
    bool _cupertino =
        _platform == TargetPlatform.iOS || _platform == TargetPlatform.macOS;

    ///根据type类型判断是否忽略平台特性
    if (FastPlatformType.material == platformType) {
      _cupertino = false;
    } else if (FastPlatformType.cupertino == platformType) {
      _cupertino = true;
    }

    ///title
    Widget? _title = _buildWidget(
      _context,
      text: title,
      textColor: titleColor,
      widget: titleWidget,
    );

    ///content
    Widget? _content = _buildWidget(
      _context,
      text: content,
      textColor: contentColor,
      widget: contentWidget,
    );

    if (_content != null && !_cupertino) {
      _content = SingleChildScrollView(
        child: _content,
      );
    }

    ///action
    List<Widget> _listAction = actions ?? [];

    ///left
    Widget? _cancel = _buildWidget(
      _context,
      text: cancel,
      textColor: cancelColor,
      widget: cancelWidget,
      cupertino: _cupertino,
      onPressed: onCancelPressed ?? () => Navigator.of(_context).pop(0),
    );

    ///right
    Widget? _ensure = _buildWidget(
      _context,
      text: ensure,
      textColor: ensureColor,
      widget: ensureWidget,
      cupertino: _cupertino,
      onPressed: onEnsurePressed ?? () => Navigator.of(_context).pop(1),
    );
    if (_cancel != null) {
      _listAction.add(_cancel);
    }
    if (_ensure != null) {
      _listAction.add(_ensure);
    }
    if (_cupertino) {
      return await showCupertinoDialog<int?>(
        context: _context,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        builder: (context) {
          return CupertinoAlertDialog(
            title: _title,
            content: _content,
            actions: _listAction,
          );
        },
      );
    }
    return await showDialog<int?>(
      context: _context,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          title: _title,

          ///设置Dialog最大宽度
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 280,
            ),
            child: _content == null
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ///中间内容部分占据剩余部分保持底部Action Button
                      Flexible(
                        child: _content,
                      ),
                    ],
                  ),
          ),
          actions: _listAction,
        );
      },
    );
  }

  ///构建Dialog widget
  static Widget? _buildWidget(
    BuildContext context, {
    String? text,
    Color? textColor,
    Widget? widget,
    bool? cupertino,
    VoidCallback? onPressed,
  }) {
    if (widget != null) {
      return widget;
    }
    if (text == null) {
      return null;
    }
    if (cupertino != null) {
      if (cupertino) {
        return CupertinoButton(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          onPressed: onPressed,
        );
      }
      return TextButton(
        style: TextButton.styleFrom(
          primary: textColor,
        ),
        child: Text(
          text,
        ),
        onPressed: () {
          ///关闭对话框并返回
          Navigator.of(context).pop(0);
        },
      );
    }
    return Text(
      text,
      style: TextStyle(color: textColor),
    );
  }
}
