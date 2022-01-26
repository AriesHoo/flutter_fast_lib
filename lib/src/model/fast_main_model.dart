import 'package:flutter/widgets.dart';
import 'package:flutter_fast_lib/src/page/fast_main_page.dart';

///[FastMainPage]
class FastMainModel {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;

  ///item长按tooltip-不想显示可设置''
  final String? tooltip;
  final Color? backgroundColor;
  final Widget page;
  final bool wantKeepAlive;

  FastMainModel({
    required this.icon,
    required this.label,
    required this.page,
    this.wantKeepAlive = true,
    this.activeIcon,
    this.tooltip,
    this.backgroundColor,
  });
}
