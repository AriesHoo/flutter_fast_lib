import 'package:flutter/material.dart';

///淡入淡出Route
class FadePageRoute<T> extends PageRouteBuilder<T> {
  FadePageRoute({
    required final WidgetBuilder builder,
    RouteSettings? settings,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
    bool opaque = true,
    bool barrierDismissible = false,
    Color? barrierColor,
    String? barrierLabel,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            settings: settings,
            transitionDuration: transitionDuration,
            reverseTransitionDuration: reverseTransitionDuration,
            opaque: opaque,
            barrierColor: barrierColor,
            barrierDismissible: barrierDismissible,
            barrierLabel: barrierLabel,
            maintainState: maintainState,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return builder(context);
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 2.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              );
            });
}
