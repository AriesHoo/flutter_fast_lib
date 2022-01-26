import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';
import 'package:flutter_fast_lib_template/util/auto_size_util.dart';
import 'package:flutter_fast_lib_template/widget/app_dialog.dart';
import 'package:flutter_fast_lib_template/widget/button.dart';

///Dialog 工具类
class DialogUtil {
  /// 弹出对话框
  static Future<int?> showAlertDialog({
    BuildContext? context,
    String? title,
    Widget? titleWidget,
    String? content,
    Widget? contentWidget,
    String? cancel,
    Color? cancelColor,
    Widget? cancelWidget,
    String? ensure,
    Widget? ensureWidget,
    Color? ensureColor,
    bool barrierDismissible = true,
    VoidCallback? onEnsureClick,
    Function(LifecycleEvent)? onLifecycleEvent,
  }) async {
    bool _isDismiss = false;
    return await showDialog<int>(
      context: context ?? currentContext,
      barrierDismissible: barrierDismissible,
      builder: (context) => LifecycleWrapper(
        child: getDialog(
          context,
          barrierDismissible: barrierDismissible,
          title: title,
          titleWidget: titleWidget,
          content: content,
          contentWidget: contentWidget,
          cancel: cancel,
          cancelWidget: cancelWidget,
          cancelColor: cancelColor,
          ensure: ensure,
          ensureColor: ensureColor,
          ensureWidget: ensureWidget,
          onClick: (i) {
            if (!_isDismiss) {
              if (1 == i && onEnsureClick != null) {
                onEnsureClick.call();
              } else {
                Navigator.of(context).pop(i);
              }
            }
          },
        ),
        onLifecycleEvent: (event) {
          if (!_isDismiss) {
            onLifecycleEvent?.call(event);
          }
          if (LifecycleEvent.pop == event) {
            _isDismiss = true;
          }
        },
      ),
    );
  }

  ///获取Dialog
  static Widget getDialog(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? content,
    Widget? contentWidget,
    String? cancel,
    Color? cancelColor,
    Widget? cancelWidget,
    String? ensure,
    Color? ensureColor,
    Widget? ensureWidget,
    bool barrierDismissible = true,
    double maxWidth = 280.0,
    double minWidth = 220.0,
    Function(int)? onClick,
  }) {
    title = title ?? appString.dialogTitle;
    Widget? widgetTitle = titleWidget ?? Text(title);
    Widget widgetContent = contentWidget ??
        (!TextUtil.isEmpty(content)
            ? Text(
                content!,
              )
            : const SizedBox());

    Widget? widgetCancel = cancelWidget ??
        (!TextUtil.isEmpty(cancel)
            ? Button(
                text: cancel!,
                backgroundColor: cancelColor ?? Colors.blueGrey,
                onPressed: () {
                  ///关闭对话框并返回
                  onClick?.call(0);
                },
              )
            : null);
    Widget? widgetEnsure = ensureWidget ??
        (!TextUtil.isEmpty(ensure)
            ? Button(
                text: ensure!,
                onPressed: () {
                  ///关闭对话框并返回
                  onClick?.call(1);
                },
              )
            : null);
    List<Widget> actions = [];
    if (widgetCancel != null) {
      actions.add(widgetCancel);
    }
    if (widgetEnsure != null) {
      actions.add(widgetEnsure);
    }
    FastLogUtil.e('isSmallDisplay:$isSmallDisplay', tag: 'getDialog');
    return WillPopScope(
      onWillPop: () async {
        return barrierDismissible;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.only(
          left: getAdapterSize(24.0),
          top: getAdapterSize(titleWidget == null ? 12.0 : 10.0),
          right: getAdapterSize(24.0),
          bottom: getAdapterSize(12.0),
        ),
        actionsPadding: const EdgeInsets.only(right: 6, bottom: 2, left: 6),
        title: widgetTitle,
        clipBehavior: Clip.antiAlias,

        ///设置Dialog最大宽度
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            minWidth: minWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///中间内容部分占据剩余部分保持底部Action Button
              Flexible(
                child: SingleChildScrollView(
                  child: widgetContent,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        actions: actions,
        buttonPadding: const EdgeInsets.only(right: 30),
      ),
    );
  }

  /// 底部BottomSheetDialog-少量
  static Future showModalBottomSheetDialog({
    required Widget child,
    BuildContext? context,
    Color? barrierColor,
    Color? backgroundColor,
    RouteSettings? settings,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.antiAlias,
  }) async {
    return await showModalBottomSheet(
      context: context ?? currentContext,
      routeSettings: settings,
      shape: shape,
      clipBehavior: clipBehavior,
      isScrollControlled: true,
      useRootNavigator: true,

      ///背景色默认设置
      backgroundColor: backgroundColor ?? Colors.transparent,

      ///背景蒙层颜色
      barrierColor: barrierColor ?? Colors.black54,

      builder: (BuildContext context) {
        return child;
      },
    );
  }

  ///弹出底部Dialog
  static Future showBottomDialog({
    required Widget child,
    BuildContext? context,
    RouteSettings? settings,
    EdgeInsetsGeometry? contentPadding,
  }) {
    if (runOniOS) {
      return showTransitionDialog(
        context: context,
        routeSettings: settings,
        child: BottomDialog(
          contentPadding: contentPadding,
          bottom: child,
        ),
      );
    }
    return showModalBottomSheetDialog(
      context: context,
      settings: settings,
      child: BottomDialog(
        contentPadding: contentPadding,
        bottom: SafeArea(
          bottom: isSmallDisplay,
          child: child,
        ),
      ),
    );
  }

  ///打开动画Dialog-缩放
  static Future<T?> showTransitionDialog<T extends Object?>({
    required Widget child,
    BuildContext? context,
    RouteSettings? routeSettings,
    bool barrierDismissible = false,
    String? barrierLabel = '',
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useRootNavigator = true,
  }) {
    return showGeneralDialog<T?>(
      context: context ?? currentContext,
      routeSettings: routeSettings,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      useRootNavigator: useRootNavigator,
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      ),
    );
  }
}
