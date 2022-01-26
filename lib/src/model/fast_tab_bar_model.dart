import 'package:flutter/cupertino.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///[FastTabBar]对应实体类
class FastTabBarModel {
  final Widget page;
  final Widget tab;
  final bool wantKeepAlive;

  FastTabBarModel({
    required this.page,
    required this.tab,
    this.wantKeepAlive = true,
  });
}
