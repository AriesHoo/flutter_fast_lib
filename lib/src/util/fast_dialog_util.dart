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
    BuildContext cxt = context ?? currentContext;

    ///默认与当前TargetPlatform保持一致
    TargetPlatform platform = Theme.of(cxt).platform;

    ///初步确定是否为Cupertino样式
    bool cupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    ///根据type类型判断是否忽略平台特性
    if (FastPlatformType.material == platformType) {
      cupertino = false;
    } else if (FastPlatformType.cupertino == platformType) {
      cupertino = true;
    }

    ///title
    Widget? titlteWidget = _buildWidget(
      cxt,
      text: title,
      textColor: titleColor,
      widget: titleWidget,
    );

    ///content
    Widget? contentView = _buildWidget(
      cxt,
      text: content,
      textColor: contentColor,
      widget: contentWidget,
    );

    if (contentView != null && !cupertino) {
      contentView = SingleChildScrollView(
        child: contentView,
      );
    }

    ///action
    List<Widget> listAction = actions ?? [];

    ///left
    Widget? cancelView = _buildWidget(
      cxt,
      text: cancel,
      textColor: cancelColor,
      widget: cancelWidget,
      cupertino: cupertino,
      onPressed: onCancelPressed ?? () => Navigator.of(cxt).pop(0),
    );

    ///right
    Widget? ensureView = _buildWidget(
      cxt,
      text: ensure,
      textColor: ensureColor,
      widget: ensureWidget,
      cupertino: cupertino,
      onPressed: onEnsurePressed ?? () => Navigator.of(cxt).pop(1),
    );
    if (cancelView != null) {
      listAction.add(cancelView);
    }
    if (ensureView != null) {
      listAction.add(ensureView);
    }
    if (cupertino) {
      return await showCupertinoDialog<int?>(
        context: cxt,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        builder: (context) {
          return CupertinoAlertDialog(
            title: titlteWidget,
            content: contentView,
            actions: listAction,
          );
        },
      );
    }
    return await showDialog<int?>(
      context: cxt,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          title: titlteWidget,

          ///设置Dialog最大宽度
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 280,
            ),
            child: contentView == null
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ///中间内容部分占据剩余部分保持底部Action Button
                      Flexible(
                        child: contentView,
                      ),
                    ],
                  ),
          ),
          actions: listAction,
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
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        );
      }
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: textColor,
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
