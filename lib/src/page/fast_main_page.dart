import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/model/fast_main_model.dart';
import 'package:lifecycle/lifecycle.dart';

///主页Tab效果--常见样式(微信、QQ、支付宝等)
///1、2021-12-02 09:09 移除拦截返回键相关逻辑代码由使用者根据情况使用[FastQuitApp]包裹
class FastMainPage extends StatefulWidget {
  const FastMainPage({
    Key? key,
    this.listTab = const [],
    this.selectTab = 0,
    this.iconSize = 28.0,
    this.unselectedFontSize = 12.0,
    this.selectedFontSize = 12.0,
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.allowImplicitScrolling = false,
    this.onLifecycleEvent,
  }) : super(key: key);

  ///单个子Widget相关属性model List
  final List<FastMainModel> listTab;

  ///选中tabIndex
  final int selectTab;

  ///默认iconSize
  final double iconSize;

  ///未选中文本size
  final double unselectedFontSize;

  ///选中文本size
  final double selectedFontSize;

  ///bottomNavigationBarType样式
  final BottomNavigationBarType? bottomNavigationBarType;

  ///控制是否可滚动
  ///BouncingScrollPhysics-允许滚动超出边界iOS默认效果
  ///ClampingScrollPhysics-防止滚动超出边界Android默认效果
  ///AlwaysScrollableScrollPhysics-始终响应用户的滚动
  ///NeverScrollableScrollPhysics-不响应用户的滚动
  final ScrollPhysics? scrollPhysics;

  ///是否加载下一页
  final bool allowImplicitScrolling;

  ///可见性变化回调---[LifecycleEvent] index -1为父控件 其它为子控件
  final Function(LifecycleEvent event, int index)? onLifecycleEvent;

  @override
  _FastMainPageState createState() => _FastMainPageState();
}

class _FastMainPageState extends State<FastMainPage> {
  final PageController _pageController = PageController();
  int _selectTabIndex = 0;

  ///数据中转--避免调用了get 方法数据重复
  List<FastMainModel> _listTab = [];

  @override
  void initState() {
    super.initState();
    _selectTabIndex = widget.selectTab;
    _listTab = widget.listTab;
    if (_listTab.isNotEmpty && _selectTabIndex != 0) {
      ///index小于list长度再赋值
      _selectTabIndex =
          widget.selectTab < _listTab.length ? widget.selectTab : 0;
      Future.delayed(
          Duration.zero, () => _pageController.jumpToPage(_selectTabIndex));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget container = _listTab.isEmpty
        ? const SizedBox()
        : Scaffold(
            body: PageViewLifecycleWrapper(
              onLifecycleEvent: (event) =>
                  widget.onLifecycleEvent?.call(event, -1),
              child: PageView.builder(
                itemBuilder: (ctx, index) => ChildPageLifecycleWrapper(
                  index: index,
                  child: _listTab[index].page,
                  wantKeepAlive: _listTab[index].wantKeepAlive,
                  onLifecycleEvent: (event) =>
                      widget.onLifecycleEvent?.call(event, index),
                ),
                itemCount: _listTab.length,
                controller: _pageController,
                allowImplicitScrolling: widget.allowImplicitScrolling,
                physics: widget.scrollPhysics,
                onPageChanged: (index) {
                  setState(() {
                    _selectTabIndex = index;
                  });
                },
              ),
            ),
            bottomNavigationBar: _listTab.length == 1
                ? null
                : BottomNavigationBar(
                    ///当前选中tab
                    currentIndex: _selectTabIndex,

                    ///点击事件
                    onTap: (index) {
                      _pageController.jumpToPage(index);
                    },
                    type: widget.bottomNavigationBarType,

                    ///背景色保持和appBar一致方便颜色主题统一
                    selectedFontSize: widget.selectedFontSize,
                    unselectedFontSize: widget.unselectedFontSize,
                    iconSize: widget.iconSize,

                    ///选中显示label
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    items: List.generate(
                      _listTab.length,
                      (index) {
                        return BottomNavigationBarItem(
                          icon: _listTab[index].icon,
                          activeIcon: _listTab[index].activeIcon,
                          label: _listTab[index].label,
                          backgroundColor: _listTab[index].backgroundColor,
                          tooltip: _listTab[index].tooltip,
                        );
                      },
                    ),
                  ),
          );
    return container;
  }
}
