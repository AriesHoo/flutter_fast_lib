import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/helper/user_helper.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/manager/route_manager.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';
import 'package:flutter_fast_lib_template/util/auto_size_util.dart';
import 'package:flutter_fast_lib_template/widget/button.dart';
import 'package:flutter_fast_lib_template/widget/image_loader.dart';

///主页TabController用于全局切换index
TabController? tabHomeController;

///主页面
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => const TabHome(),
    );
  }
}

///主页tab标签
class TabHome extends FastTabBar {
  const TabHome({
    Key? key,
  }) : super(key: key);

  @override
  Function(TabController controller)? get tabController =>
      (controller) => tabHomeController = controller;

  @override
  bool get tabBarInTitle => MediaQuery.of(currentContext).size.width >= 720;

  @override
  bool get isScrollable => true;

  @override
  bool get withPageView => false;

  @override
  bool? get centerTitle => false;

  @override
  int get initialIndex => 0;

  @override
  List<Widget>? get actions => [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///登录(已登录用户头像)
            UserHelper.isLogin()
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSpaceMedium(),
                    ),
                    child: NetworkImageLoader(
                      url: UserHelper.getImageUrl(),
                      width: 40,
                      height: 40,
                      borderRadius: BorderRadius.circular(getSpaceMedium()),
                    ),
                  )
                : Button(
                    onPressed: () => FastToastUtil.showSuccess(appString.login),
                    text: appString.login,
                    margin: EdgeInsets.symmetric(horizontal: getSpaceMedium()),
                  ),

            ///下载App
            Button(
              onPressed: () {
                if (runOnMobile) {
                  openUrl(AppConstant.downloadApkUrl);
                } else {
                  Navigator.of(currentContext).pushNamedAndRemoveUntil(
                    RouteName.downloadApp,
                    (route) => false,
                  );
                }
              },
              margin: EdgeInsets.only(right: getSpaceMedium()),
              text: appString.downloadApp,
            ),
          ],
        ),
      ];

  @override
  List<FastTabBarModel> get tabBars => Colors.primaries.map(
        (e) {
          int index = Colors.primaries.indexOf(e);
          return FastTabBarModel(
            page: ColoredBox(
              color: e,
              child: Center(
                child: Text(
                  'page$index',
                ),
              ),
            ),
            tab: Tab(
              text: 'tab$index',
            ),
          );
        },
      ).toList();

  @override
  Color? get indicatorColor => Theme.of(currentContext).colorScheme.primary;

  @override
  ScrollPhysics? get physics =>
      runOnMobile ? null : const NeverScrollableScrollPhysics();
}
