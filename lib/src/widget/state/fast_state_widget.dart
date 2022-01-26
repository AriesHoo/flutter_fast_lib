import 'package:flutter/material.dart';

/// 基础Widget
class FastStateWidget extends StatelessWidget {
  final double? height;
  final Widget? message;
  final Widget? image;
  final Widget? button;
  final GestureTapCallback? onPressed;

  const FastStateWidget({
    Key? key,
    this.height,
    this.image,
    this.message,
    this.button,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget center = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image ?? const SizedBox(),
            message ?? const SizedBox(),
            button ?? const SizedBox(),
          ],
        ),
      ),
    );
    return SizedBox(
      height: height,
      child: onPressed != null
          ? InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: center,
      )
          : center,
    );
  }
}
