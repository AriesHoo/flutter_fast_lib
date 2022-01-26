import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/util/auto_size_util.dart';
import 'package:flutter_fast_lib_template/view_model/highlight_view_model.dart';

///长按效果Card-包括景深度、margin变化
class HighlightCardWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final double? margin;
  final double? marginHighlight;
  final double? elevation;
  final double? elevationHighlight;
  final Color? color;
  final Color? shadowColor;
  final Color? shadowHighlightColor;
  final BorderRadiusGeometry? borderRadius;
  final Widget Function(BuildContext context, HighlightViewModel value)
      builder;

  const HighlightCardWidget({
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
    darkMode = true;
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
            model.highlight
                ? marginHighlight ?? getSpaceMini()
                : margin ?? getSpaceSmall(),
          ),
          elevation: darkMode
              ? 0
              : model.highlight
                  ? elevationHighlight ?? getSpaceMedium()
                  : elevation ?? getSpaceSmall(),
          color: color ?? Theme.of(context).cardColor,
          borderOnForeground: false,
          // shadowColor: model.highlight
          //     ? shadowHighlightColor ?? Colors.deepPurpleAccent
          //     : shadowColor ?? Theme.of(context).primaryColor,
          child: builder(context, model),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  getSpaceSmall(),
                ),
            side: darkMode
                ? BorderSide(
                    width: getAdapterSize(model.highlight ? 1.2 : 0.75),
                    color: Theme.of(context).hintColor.withOpacity(0.11),
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
