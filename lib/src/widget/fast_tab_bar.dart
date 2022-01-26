import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///[TabBar]+[TabBarView]或 [TabBar]+[PageView]
///1、2021-12-02 09:09 移除拦截返回键相关逻辑代码由使用者根据情况使用[FastQuitApp]包裹
///2、2021-12-08 10:34 TabBar使用Theme包裹避免因主题切换背景色未及时生效问题-未找到原因;
///                    修改默认tabBarColor逻辑;增加padding onTap enableFeedback overlayColor等属性
///3、2021-12-30 10:46 修改[tabController] 为回调用于回传[TabController] 控制选择tabIndex
///4、2022-01-05 09:30 修改title为titleBuilder用于再次处理[AppBar] title属性
///5、2022-01-06 09:30 修改backgroundColor为整个页面[Scaffold]的背景另外增加[appBarBackgroundColor]属性用于设置[AppBar]背景
class FastTabBar extends StatefulWidget {
  const FastTabBar({
    Key? key,
    this.tabBars = const [],
    this.initialIndex = 0,
    this.tabController,
    this.pageController,
    this.hideTabBarWhenSingle = true,
    this.tabBarInTitle = false,
    this.withPageView = false,
    this.backgroundColor,
    this.appBarSize,
    this.leading,
    this.titleBuilder,
    this.actions,
    this.centerTitle,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.appBarBackgroundColor,
    this.flexibleSpace,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.systemOverlayStyle,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.physics,
    this.indicatorWeight = 1.5,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize = TabBarIndicatorSize.label,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.overlayColor,
    this.enableFeedback = true,
    this.onTap,
    this.tabBarSize,
    this.tabColor,
    this.tabDecoration,
    this.onLifecycleEvent,
  }) : super(key: key);

  final List<FastTabBarModel> tabBars;

  ///初始化选择index
  final int initialIndex;

  ///TabController改好回调--用于外部动态切换tab
  final Function(TabController controller)? tabController;

  ///PageController改好回调--用于外部动态切换tab
  final Function(PageController controller)? pageController;

  ///当单个tab隐藏TabBar
  final bool hideTabBarWhenSingle;

  ///tab是否在AppBar title部分-false;title属性才有效否则title为[TabBar]组件
  final bool tabBarInTitle;

  ///是否[TabBar]+[PageView]组合默认[TabBar]+[TabBarView]
  final bool withPageView;

  ///设置整个页面背景Scaffold的背景
  final Color? backgroundColor;

  ///设置appBar Size
  final Size? appBarSize;
  final Widget? leading;
  final Widget? Function(BuildContext context, Widget? title)? titleBuilder;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? appBarBackgroundColor;
  final Widget? flexibleSpace;
  final TextStyle? titleTextStyle;
  final TextStyle? toolbarTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  /// TabBar属性开始
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final Color? indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final ScrollPhysics? physics;

  ///指示器配置--默认属性来自Theme.of(context).tabBarTheme
  final Decoration? indicator;
  final TabBarIndicatorSize? indicatorSize;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;
  final MaterialStateProperty<Color?>? overlayColor;
  final bool? enableFeedback;
  final ValueChanged<int>? onTap;

  /// TabBar属性结束

  ///设置tabBar Size
  final Size? tabBarSize;

  ///tab背景色-与tabDecoration不同时设置
  final Color? tabColor;

  ///tab背景装饰品--增加类型下划线
  final Decoration? tabDecoration;

  ///可见性变化回调---[LifecycleEvent] index -1为父控件 其它为子控件
  final Function(LifecycleEvent event, int index, Widget widget)?
      onLifecycleEvent;

  static double kTabHeight = 46.0;
  static double kTextAndIconTabHeight = 72.0;

  @override
  _FastTabBarState createState() => _FastTabBarState();
}

class _FastTabBarState extends State<FastTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController? _pageController;
  late List<FastTabBarModel> _tabBars;

  Size get preferredTabSize {
    if (widget.tabBarSize != null) {
      return widget.tabBarSize!;
    }
    for (final FastTabBarModel item in _tabBars) {
      if (item.tab is Tab) {
        final Tab tab = item.tab as Tab;
        if ((tab.text != null || tab.child != null) && tab.icon != null) {
          return Size.fromHeight(
              FastTabBar.kTextAndIconTabHeight + widget.indicatorWeight);
        }
      }
    }
    return Size.fromHeight(FastTabBar.kTabHeight + widget.indicatorWeight);
  }

  @override
  void initState() {
    super.initState();
    if (widget.withPageView) {
      _pageController = PageController();

      ///回传PageController
      widget.pageController?.call(_pageController!);
    }
    _tabBars = widget.tabBars;
    _tabController = TabController(
      length: _tabBars.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && widget.withPageView) {
        _pageController?.jumpToPage(_tabController.index);
      }
    });

    ///回传TabController
    widget.tabController?.call(_tabController);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.withPageView) {
      _pageController?.dispose();
    }
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///tab为1且设置单个隐藏就不显示tabBar
    bool showTab = _tabBars.length > 1 || !widget.hideTabBarWhenSingle;

    ///Tab
    Widget _tabBar = TabBar(
      tabs: _tabBars.map((e) => e.tab).toList(),
      controller: _tabController,
      isScrollable: widget.isScrollable,
      padding: widget.padding,
      indicatorColor: widget.indicatorColor ?? Theme
          .of(context)
          .colorScheme
          .primary,
      automaticIndicatorColorAdjustment: true,
      indicatorWeight: widget.indicatorWeight,
      indicatorPadding: widget.indicatorPadding,

      indicator: widget.indicator,
      indicatorSize: widget.indicatorSize,
      labelColor: widget.labelColor,
      labelStyle: widget.labelStyle,
      labelPadding: widget.labelPadding,
      unselectedLabelColor: widget.unselectedLabelColor,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      overlayColor: widget.overlayColor,

      /// 触摸反馈
      enableFeedback: widget.enableFeedback,
      onTap: widget.onTap,
      physics: widget.physics,
    );

    ///主题设置-避免某些情况下主题切换未及时生效问题
    _tabBar = Theme(data: Theme.of(context), child: _tabBar);

    ///TabBar Size
    Size _tabSize = showTab ? preferredTabSize : Size.zero;

    ///尺寸定制化TabBar
    PreferredSizeWidget _tabBarWidget = PreferredSize(
      child: showTab
          ? Container(
        height: showTab ? _tabSize.height : 0.0,
        width: _tabSize.width,
        child: _tabBar,
        color: widget.tabDecoration == null
            ? (widget.tabColor ??
            Theme
                .of(context)
                .appBarTheme
                .backgroundColor ??
            Theme
                .of(context)
                .cardColor)
            : null,
        decoration: widget.tabDecoration,
      )
          : const SizedBox(),
      preferredSize: _tabSize,
    );

    ///AppBar bottom
    PreferredSizeWidget? _bottom = widget.tabBarInTitle ? null : _tabBarWidget;

    ///appBar最终Size
    Size _appSize = Size.fromHeight((widget.appBarSize != null
        ? widget.appBarSize!.height
        : kToolbarHeight) +
        (_bottom?.preferredSize.height ?? 0.0));

    ///遍历TabBar子集
    List<Widget> _listWidget = _tabBars.map(
          (e) {
        int index = _tabBars.indexOf(e);
        return ChildPageLifecycleWrapper(
          index: index,
          child: e.page,
          wantKeepAlive: e.wantKeepAlive,
          onLifecycleEvent: (event) =>
              widget.onLifecycleEvent?.call(event, index, e.page),
        );
      },
    ).toList();

    /// 是否显示AppBar
    bool showAppBar = widget.tabBarInTitle ||
        widget.leading != null ||
        ObjectUtil.isNotEmpty(widget.actions);

    ///最终title--将title回调回去由最终调用处理并可设置TabBar位置
    Widget? _title = widget.titleBuilder != null
        ? widget.titleBuilder!(
      context,
      widget.tabBarInTitle ? _tabBarWidget : null,
    )
        : null;
    showAppBar = _title != null || showAppBar;
    Widget container = Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: _appSize,
        child: showAppBar
            ? AppBar(
          leading: widget.leading,
          actions: widget.actions,
          title: _title ?? (widget.tabBarInTitle ? _tabBarWidget : null),
          bottom: _bottom,
          backgroundColor: widget.appBarBackgroundColor,
          flexibleSpace: widget.flexibleSpace,
          titleTextStyle: widget.titleTextStyle,
          toolbarTextStyle: widget.toolbarTextStyle,
          iconTheme: widget.iconTheme,
          actionsIconTheme: widget.actionsIconTheme,
          systemOverlayStyle: widget.systemOverlayStyle,
        )
            : _tabBarWidget,
      ),
      body: PageViewLifecycleWrapper(
        onLifecycleEvent: (event) =>
            widget.onLifecycleEvent?.call(event, -1, widget),
        child: widget.withPageView
            ? PageView(
          children: _listWidget,
          physics: widget.physics,
          onPageChanged: (pageIndex) =>
              _tabController.animateTo(pageIndex),
          controller: _pageController,
        )
            : TabBarView(
          physics: widget.physics,
          controller: _tabController,
          children: _listWidget,
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
    return container;
  }
}
