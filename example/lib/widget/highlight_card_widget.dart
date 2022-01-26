import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/util/decoration_util.dart';
import 'package:flutter_fast_lib_example/view_model/highlight_view_model.dart';

///长按/悬浮效果Card-包括景深度、margin变化
class HighlightCardWidget extends StatelessWidget {
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

  const HighlightCardWidget({
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
    this.showBorder = false,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasisProviderWidget<HighlightViewModel>(
      model: HighlightViewModel(),
      builder: (context, highlightMode, widget) => Card(
        margin: FastPlatformUtil.isMobile && !showBorder
            ? null
            : EdgeInsets.all(
                highlightMode.highlight ? marginHighlight ?? 10 : margin ?? 10,
              ),
        elevation: highlightMode.highlight ? 0 : 0,
        color: Colors.transparent,
        borderOnForeground: false,
        shadowColor: highlightMode.highlight
            ? shadowHighlightColor ?? Colors.deepPurpleAccent
            : shadowColor ?? Theme.of(context).colorScheme.primary,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: FastPlatformUtil.isMobile && !showBorder
            ? null
            : DecorationUtil.lineShapeBorder(
                context,
                lineWidth: highlightMode.highlight ? 1.6 : 0.8,
                borderRadius: BorderRadius.circular(12),
                color: highlightMode.highlight
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).hintColor.withOpacity(0.1),
              ),
        child: InkWell(
          canRequestFocus: true,
          autofocus: true,
          onHighlightChanged: highlightMode.onHighlightChanged,
          onHover: highlightMode.onHighlightChanged,
          // highlightColor: PlatformUtil.isMobile ? null : Colors.transparent,
          // splashColor: PlatformUtil.isMobile ? null : Colors.transparent,
          // hoverColor: PlatformUtil.isMobile ? null : Colors.transparent,
          onTap: () {
            onTap?.call();
            highlightMode.onHighlightChanged.call(!FastPlatformUtil.isMobile);
          },
          onLongPress: onLongPress != null
              ? () {
                  onLongPress?.call();
                  highlightMode.onHighlightChanged
                      .call(!FastPlatformUtil.isMobile);
                }
              : null,
          child: builder(context, highlightMode),
        ),
      ),
    );
  }
}

class HighlightCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final double? margin;
  final double? marginHighlight;
  final double? elevation;
  final double? elevationHighlight;
  final Color? color;
  final Color? shadowColor;
  final Color? shadowHighlightColor;
  final BorderRadiusGeometry? borderRadius;
  final Widget Function(BuildContext context, HighlightViewModel value) builder;

  const HighlightCard({
    Key? key,
    this.onTap,
    this.margin,
    this.marginHighlight,
    this.elevation,
    this.elevationHighlight,
    this.color,
    this.shadowColor,
    this.shadowHighlightColor,
    this.borderRadius,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return BasisProviderWidget<HighlightViewModel>(
      model: HighlightViewModel(),
      builder: (context, model, widget) => InkWell(
        onHighlightChanged: model.onHighlightChanged,
        onHover: model.onHighlightChanged,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => onTap?.call(),
        child: Card(
          margin: EdgeInsets.all(
            model.highlight ? marginHighlight ?? 6 : margin ?? 12,
          ),
          elevation: darkMode
              ? 0
              : model.highlight
                  ? elevationHighlight ?? 16
                  : elevation ?? 12,
          color: color ?? Theme.of(context).cardColor,
          borderOnForeground: false,
          shadowColor: model.highlight
              ? shadowHighlightColor ?? Colors.deepPurpleAccent
              : shadowColor ?? Theme.of(context).colorScheme.primary,
          child: builder(context, model),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  12,
                ),
            side: darkMode
                ? BorderSide(
                    width: 1,
                    color: Theme.of(context).hintColor.withOpacity(0.1),
                    // color: Colors.blue,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
