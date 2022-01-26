import 'package:flutter/material.dart';

/// 加载中
class FastLoadingStateWidget extends StatelessWidget {
  final Color? background;
  final Widget? loading;
  final Widget? text;

  const FastLoadingStateWidget({
    Key? key,
    this.background,
    this.loading,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = loading ?? const CircularProgressIndicator();
    return Center(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: background ?? Colors.transparent,
          borderRadius: BorderRadius.circular(
            background != null ? 10 : 6,
          ),
        ),
        padding: text == null
            ? EdgeInsets.all(
                background != null ? 32 : 16,
              )
            : EdgeInsets.symmetric(
                vertical: background != null ? 32 : 16,
                horizontal: background != null ? 32 : 24,
              ),
        child: text == null
            ? loadingWidget
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loadingWidget,
                  const SizedBox(
                    height: 16,
                  ),
                  text!,
                ],
              ),
      ),
    );
  }
}
