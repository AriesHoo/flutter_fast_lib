import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/main.dart';
import 'package:flutter_fast_lib_example/page/explore/tab_explore.dart';

///[FastTabBar]示例--Freadhub示例
class FastTabBarPage extends FastTabBar {
  const FastTabBarPage({Key? key}) : super(key: key);

  @override
  bool get tabBarInTitle => true;

  @override
  bool get withPageView => false;

  @override
  bool get isScrollable => false;

  @override
  Color? get tabColor => Theme.of(currentContext).appBarTheme.backgroundColor;

  // @override
  // Size? get appBarSize => Size.zero;

  // @override
  // Size? get tabBarSize => Size.fromHeight(36);

  // @override
  // Widget? get title => Column(
  //       children: [
  //         Text(
  //           'Freadhub资讯',
  //           style: TextStyle(
  //             fontSize: 13,
  //           ),
  //         ),
  //       ],
  //     );

  @override
  List<FastTabBarModel> get tabBars => [
        FastTabBarModel(
          page: const TabExplore(
            url: 'topic',
            // onModelReady: (model) => listArticle[0] = model,
          ),
          tab: Tab(text: appString.tabArticleTopic),
        ),
        FastTabBarModel(
          page: const TabExplore(
            url: 'news',
            // onModelReady: (model) => listArticle[1] = model,
          ),
          tab: Tab(
            text: appString.tabArticleNews,
          ),
        ),
        FastTabBarModel(
          page: const TabExplore(
            url: 'technews',
            // onModelReady: (model) => listArticle[2] = model,
          ),
          tab: Tab(text: appString.tabArticleTechNews),
        ),
      ];

  // @override
  // Function(LifecycleEvent event, int index, Widget widget)?
  //     get onLifecycleEvent => (event, index, widget) {
  //           FastLogUtil.e('event:$event;index:$index;widget:$widget',
  //               tag: 'FastTabBarPageLifecycleEvent');
  //           if (event == LifecycleEvent.active) {
  //             if (widget is TabExplore) {
  //               listArticle[index]?.preRefresh();
  //             }
  //           }
  //         };
  //
  // static List<ArticleViewModel?> listArticle = [null, null, null];
}
