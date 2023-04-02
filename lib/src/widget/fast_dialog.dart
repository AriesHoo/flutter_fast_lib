import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';

///[Dialog]的魔改版--扩展部分属性
///1、2021-12-27 09:20 修改isDismissible 为 [dismissible]
///1、2021-12-27 09:38 增加 内边距[contentPadding] 是否关闭按钮 [closable] 关闭按钮位置 [closeAlignment] 自定义关闭按钮[closeButton]
class FastDialog extends StatelessWidget {
  const FastDialog({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding,
    this.clipBehavior,
    this.shape,
    this.child,
    this.minWidth,
    this.maxWidth,
    this.maxHeight,
    this.alignment = Alignment.center,
    this.scrollable,
    this.shadowColor,
    this.dismissible = true,
    this.contentPadding,
    this.closable,
    this.closeAlignment,
    this.closeButton,
  }) : super(key: key);

  /// {@template flutter.material.dialog.backgroundColor}
  /// The background color of the surface of this [Dialog].
  ///
  /// This sets the [Material.color] on this [Dialog]'s [Material].
  ///
  /// If `null`, [ThemeData.dialogBackgroundColor] is used.
  /// {@endtemplate}
  final Color? backgroundColor;

  /// {@template flutter.material.dialog.elevation}
  /// The z-coordinate of this [Dialog].
  ///
  /// If null then [DialogTheme.elevation] is used, and if that's null then the
  /// dialog's elevation is 24.0.
  /// {@endtemplate}
  /// {@macro flutter.material.material.elevation}
  final double? elevation;

  /// {@template flutter.material.dialog.insetAnimationDuration}
  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  /// {@endtemplate}
  final Duration insetAnimationDuration;

  /// {@template flutter.material.dialog.insetAnimationCurve}
  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.decelerate].
  /// {@endtemplate}
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.insetPadding}
  /// The amount of padding added to [MediaQueryData.viewInsets] on the outside
  /// of the dialog. This defines the minimum space between the screen's edges
  /// and the dialog.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
  /// {@endtemplate}
  final EdgeInsets? insetPadding;

  /// {@template flutter.material.dialog.clipBehavior}
  /// Controls how the contents of the dialog are clipped (or not) to the given
  /// [shape].
  ///
  /// See the enum [Clip] for details of all possible options and their common
  /// use cases.
  ///
  /// Defaults to [Clip.none], and must not be null.
  /// {@endtemplate}
  final Clip? clipBehavior;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 4.0
  /// {@endtemplate}
  final ShapeBorder? shape;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  ///最大宽度
  final double? maxWidth;

  ///最小宽度
  final double? minWidth;

  ///最大高度
  final double? maxHeight;

  ///对齐方式
  final AlignmentGeometry alignment;

  ///可否自动滚动
  final bool? scrollable;

  ///点击非child区域是否可关闭
  final bool dismissible;
  final Color? shadowColor;

  ///内边距
  final EdgeInsetsGeometry? contentPadding;

  ///是否显示一个关闭按钮--web显示/其它不显示
  final bool? closable;

  ///关闭按钮位置
  final AlignmentGeometry? closeAlignment;

  ///关闭按钮
  final Widget? closeButton;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery
        .of(context)
        .viewInsets +
        (insetPadding ??
            FastManager
                .getInstance()
                .dialogMixin
                .defaultInsetPadding);
    bool _scrollable =
        scrollable ?? FastManager
            .getInstance()
            .dialogMixin
            .scrollable;
    double maxBoxWidth =
        maxWidth ?? FastManager
            .getInstance()
            .dialogMixin
            .maxWidth;
    double minBoxWidth =
        minWidth ?? FastManager
            .getInstance()
            .dialogMixin
            .minWidth;

    double maxBoxHeight =
        maxHeight ?? FastManager
            .getInstance()
            .dialogMixin
            .maxHeight;

    ///添加内边距
    Widget _child = Padding(
      padding: contentPadding ??
          FastManager
              .getInstance()
              .dialogMixin
              .defaultContentPadding ??
          EdgeInsets.zero,
      child: child,
    );

    ///内容可滚动
    if (_scrollable) {
      _child = SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: _child,
      );
    }

    ///是否显示可关闭按钮
    bool _closable =
        closable ?? FastManager
            .getInstance()
            .dialogMixin
            .closable ?? kIsWeb;

    ///添加CloseButton
    if (_closable) {
      _child = Stack(
        alignment: closeAlignment ??
            FastManager
                .getInstance()
                .dialogMixin
                .closeAlignment ??
            AlignmentDirectional.topEnd,
        children: [
          _child,
          closeButton ??
              FastManager
                  .getInstance()
                  .dialogMixin
                  .closeButton ??
              const CloseButton(),
        ],
      );
    }
    Widget childWidget = AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          heightFactor: 1,
          widthFactor: 1,
          alignment: alignment,
          child: Material(
            color: backgroundColor ??
                dialogTheme.backgroundColor ??
                Theme
                    .of(context)
                    .dialogBackgroundColor,
            elevation: elevation ??
                dialogTheme.elevation ??
                FastManager
                    .getInstance()
                    .dialogMixin
                    .defaultElevation,
            shape: shape ??
                dialogTheme.shape ??
                FastManager
                    .getInstance()
                    .dialogMixin
                    .defaultDialogShape,
            shadowColor: FastManager
                .getInstance()
                .dialogMixin
                .shadowColor,
            type: MaterialType.card,
            clipBehavior: clipBehavior ??
                FastManager
                    .getInstance()
                    .dialogMixin
                    .clipBehavior,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minBoxWidth,
                maxWidth: maxBoxWidth,
                maxHeight: maxBoxHeight,
              ),
              child: GestureDetector(
                onTap: () =>
                {
                  ///点击child部分不做关闭操作
                },
                child: _child,
              ),
            ),
          ),
        ),
      ),
    );

    ///可点击外部-ModalBottomSheet 特殊处理点击非child部分关闭
    if (dismissible) {
      childWidget = Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: childWidget,
          onTap: () => Navigator.of(context).pop(),
        ),
      );
    }
    return childWidget;
  }
}
