import 'package:flutter/material.dart';

///TextButton初步封装
class Button extends StatelessWidget {
  const Button.infinity({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.iconPadding = const EdgeInsets.only(right: 6),
    this.text = '',
    this.child,
    this.width = double.infinity,
    this.height,
    this.minHeight = 46,
    this.minWidth = 0,
    this.padding,
    this.paddingAll,
    this.paddingLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.shape,
    this.radius = 10,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.margin,
    this.textStyle,
    this.fontSize,
  }) : super(key: key);

  const Button({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.iconPadding = const EdgeInsets.only(right: 6),
    this.text = '',
    this.child,
    this.width,
    this.height,
    this.minHeight = 36,
    this.minWidth = 0,
    this.padding,
    this.paddingAll,
    this.paddingLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.shape,
    this.radius,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.margin,
    this.textStyle,
    this.fontSize,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? icon;
  final EdgeInsetsGeometry? iconPadding;
  final String text;
  final Widget? child;
  final double? width;
  final double? height;
  final double minHeight;
  final double minWidth;
  final MaterialStateProperty<EdgeInsetsGeometry?>? padding;
  final double? paddingAll;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  final double? radius;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final EdgeInsetsGeometry? margin;
  final MaterialStateProperty<TextStyle?>? textStyle;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    var _bgColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    var _padding = padding;
    if (_padding == null &&
        (paddingAll != null ||
            paddingLeft != null ||
            paddingTop != null ||
            paddingRight != null ||
            paddingBottom != null)) {
      _padding = MaterialStateProperty.all(
        EdgeInsets.only(
          left: paddingLeft ?? paddingAll ?? 0,
          top: paddingTop ?? paddingAll ?? 0,
          right: paddingRight ?? paddingAll ?? 0,
          bottom: paddingBottom ?? paddingAll ?? 0,
        ),
      );
    }
    var _shape = shape;
    if (_shape == null &&
        (radius != null ||
            radiusTopLeft != null ||
            radiusTopRight != null ||
            radiusBottomLeft != null ||
            radiusBottomRight != null)) {
      _shape = MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusTopLeft ?? radius ?? 0),
            topRight: Radius.circular(radiusTopRight ?? radius ?? 0),
            bottomLeft: Radius.circular(radiusBottomLeft ?? radius ?? 0),
            bottomRight: Radius.circular(radiusBottomRight ?? radius ?? 0),
          ),
        ),
      );
    }
    var _kid = Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: minWidth,
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Colors.transparent == _bgColor
                  ? _bgColor
                  : states.contains(MaterialState.disabled)
                      ? _bgColor.withOpacity(0.5)
                      : states.contains(MaterialState.pressed)
                          ? _bgColor.withOpacity(0.8)
                          : _bgColor,
            ),
            foregroundColor:
                MaterialStateProperty.all(foregroundColor ?? Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            padding: _padding,
            shape: _shape,
            alignment: Alignment.center,
            textStyle: textStyle ??
                MaterialStateProperty.all(
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: icon != null && iconPadding != null
                    ? iconPadding!
                    : EdgeInsets.zero,
                child: icon ?? const SizedBox(),
              ),
              child ?? Text(text),
            ],
          ),
        ),
      ),
    );
    return width != null || height != null
        ? SizedBox(
            width: width,
            height: height,
            child: _kid,
          )
        : _kid;
  }
}
