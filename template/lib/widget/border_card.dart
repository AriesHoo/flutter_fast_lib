import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/view_model/highlight_view_model.dart';

///长按/悬浮效果Card-包括景深度、margin变化
class BorderCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  final double? margin;
  final double? marginHighlight;
  final double? elevation;
  final double? elevationHighlight;
  final Color? color;
  final Color? shadowColor;
  final Color? shadowHighlightColor;
  final BorderRadiusGeometry? borderRadius;
  final bool showBorder;
  final Widget Function(BuildContext context, HighlightViewModel value) builder;

  const BorderCard({
    Key? key,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.marginHighlight,
    this.elevation,
    this.elevationHighlight,
    this.color,
    this.shadowColor,
    this.shadowHighlightColor,
    this.borderRadius,
    this.showBorder = true,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasisProviderWidget<HighlightViewModel>(
      model: HighlightViewModel(),
      builder: (context, highlightMode, widget) => InkWell(
        canRequestFocus: false,
        autofocus: false,
        onHighlightChanged: highlightMode.onHighlightChanged,
        onHover: highlightMode.onHighlightChanged,
        highlightColor: showBorder ? Colors.transparent : null,
        splashColor: showBorder ? Colors.transparent : null,
        hoverColor: showBorder ? Colors.transparent : null,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Card(
          margin: FastPlatformUtil.isMobile && !showBorder
              ? EdgeInsets.zero
              : EdgeInsets.all(
                  highlightMode.highlight ? marginHighlight ?? 6 : margin ?? 10,
                ),
          elevation: highlightMode.highlight ? 0 : 0,
          color: Colors.transparent,
          borderOnForeground: false,
          shadowColor: highlightMode.highlight
              ? shadowHighlightColor ?? Colors.deepPurpleAccent
              : shadowColor ?? Theme.of(context).colorScheme.primary,
          clipBehavior: Clip.antiAlias,
          shape: FastPlatformUtil.isMobile && !showBorder
              ? null
              : _lineShapeBorder(
                  context,
                  lineWidth: highlightMode.highlight ? 2 : 1,
                  borderRadius: BorderRadius.circular(8),
                  color: highlightMode.highlight
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).hintColor.withOpacity(0.11),
                ),
          child: Padding(
            padding: EdgeInsets.all(highlightMode.highlight ? 2 : 1),
            child: builder(context, highlightMode),
          ),
        ),
      ),
    );
  }

  ///添加边缘线
  ShapeBorder _lineShapeBorder(
    BuildContext context, {
    Color? color,
    double? lineWidth,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
  }) {
    // BeveledRectangleBorder
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        width: lineWidth ?? 0.3,
        color: color ?? Theme.of(context).hintColor.withOpacity(0.01),
        style: BorderStyle.solid,
      ),
    );
  }
}
