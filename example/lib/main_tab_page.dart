import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/main.dart';
import 'package:flutter_fast_lib_example/page/explore/tab_explore.dart';
import 'package:flutter_fast_lib_example/page/index/tab_index.dart';
import 'package:flutter_fast_lib_example/page/web/tab_web.dart';

///主页tab
class MainTabPage extends FastMainPage {
  const MainTabPage({Key? key}) : super(key: key);

  // @override
  // int? Function(bool firstBack) get quitBack => (first) => null;

  @override
  List<FastMainModel> get listTab => [
        FastMainModel(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: appString.tabIndex,
          page: const TabIndex(),
        ),
        FastMainModel(
          icon: const Icon(Icons.web_outlined),
          activeIcon: const Icon(Icons.web),
          label: appString.tabWeb,
          page: const TabWeb(),
        ),
        FastMainModel(
          icon: const Icon(Icons.explore_outlined),
          activeIcon: const Icon(Icons.explore),
          label: appString.tabExplore,
          page: const TabExplore(
            url: 'topic',
            showAppBar: true,
          ),
        ),
      ];

  @override
  Function(LifecycleEvent event, int index)? get onLifecycleEvent =>
      (event, index) => FastLogUtil.e('event:$event,index:$index',
          tag: 'MainTabPageLifecycleEvent');
}
