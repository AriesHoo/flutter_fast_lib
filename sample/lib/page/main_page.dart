import 'package:flutter/material.dart';
import 'package:flutter_blood_belfry/main.dart';
import 'package:flutter_blood_belfry/page/home_page.dart';
import 'package:flutter_blood_belfry/page/rule_page.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';


///主页面TabPage
class MainPage extends FastMainPage {
  const MainPage({Key? key}) : super(key: key);

  @override
  // TODO: implement listTab
  List<FastMainModel> get listTab {
    List<FastMainModel> list = [];
    list.add(
      FastMainModel(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home),
        label: appString.homePage,
        page: const HomePage(),
      ),
    );
    list.add(
      FastMainModel(
        icon: const Icon(Icons.explore_outlined),
        activeIcon: const Icon(Icons.explore),
        label: appString.gameRule,
        page: const RulePage(),
      ),
    );
    return list;
  }
}