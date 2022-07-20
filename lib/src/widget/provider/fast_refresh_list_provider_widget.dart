import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/view_model/fast_refresh_list_view_model.dart';
import 'package:flutter_fast_lib/src/widget/provider/fast_list_provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///配合下拉刷新功能--配合上拉加载更多及返回顶部
///1、2021-12-03 08:53 修改 appBar=>[appBarBuilder] floatingActionButton=>[floatingActionButtonBuilder] bottomNavigationBar=>[bottomNavigationBarBuilder]
///2、2022-01-07 09:44 增加[onModelReady]回调前处理逻辑
class FastRefreshListProviderWidget<A extends FastRefreshListViewModel>
    extends FastListProviderWidget<A> {
  FastRefreshListProviderWidget({
    Key? key,
    required A model,
    bool inScaffold = true,
    bool? footerSafeArea,
    SliverGridDelegate? gridDelegate,
    Axis scrollDirection = Axis.vertical,
    double? itemExtent,
    double? cacheExtent,
    Color? backgroundColor,
    Function(A)? onModelReady,
    PreferredSizeWidget? Function(BuildContext context, A model)? appBarBuilder,
    Widget? Function(BuildContext context, A)? floatingActionButtonBuilder,
    Widget? Function(BuildContext context, A)? bottomNavigationBarBuilder,
    RefreshIndicator Function(BuildContext context)? headerBuilder,
    LoadIndicator Function(RefreshController? controller)? footerBuilder,
    Widget Function(BuildContext context, A model, int index)? itemBuilder,
    Widget Function(BuildContext context, A model, Widget? child)? childBuilder,
    Widget Function(BuildContext context, A model)? loadingBuilder,
    Widget Function(BuildContext context, A model)? emptyBuilder,
    Widget Function(BuildContext context, A model)? errorBuilder,
    Widget? Function(BuildContext context, A moder)? scrollBuilder,
    bool Function(BuildContext context, A model, int index)? safeItemBottom,
  })  : assert(itemBuilder != null || childBuilder != null,
            'You should specify either a itemBuilder or a childBuilder'),
        super(
          key: key,
          model: model,
          inScaffold: inScaffold,
          gridDelegate: gridDelegate,
          scrollDirection: scrollDirection,
          itemExtent: itemExtent,
          cacheExtent: cacheExtent,
          backgroundColor: backgroundColor,
          onModelReady: (model) {
            ///回调前处理滚动底部刷新逻辑
            FastManager.getInstance()
                .refreshListMixin
                .onBeforeModelReady(model);
            onModelReady?.call(model);
          },
          appBarBuilder: appBarBuilder,
          floatingActionButtonBuilder: floatingActionButtonBuilder,
          bottomNavigationBarBuilder: bottomNavigationBarBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
          scrollBuilder: scrollBuilder,
          safeItemBottom: safeItemBottom,
          itemBuilder: itemBuilder,
          childBuilder: (context, m1, child) {
            return SmartRefresher(
                enablePullDown: m1.enablePullDown,
                enablePullUp: m1.enablePullUp,
                header: headerBuilder != null
                    ? headerBuilder(context)
                    : FastManager.getInstance()
                        .refreshListMixin
                        .headerBuilder(context),
                footer: footerBuilder != null
                    ? footerBuilder(m1.refreshController)
                    : FastManager.getInstance()
                        .refreshListMixin
                        .footerBuilder(m1.refreshController, footerSafeArea),

                ///下拉刷新监听
                onRefresh: m1.refresh,

                ///上拉加载更多监听
                onLoading: m1.loadMore,

                ///刷新控制器
                controller: m1.refreshController,
                scrollController: m1.scrollTopController.scrollController,
                primary: false,

                ///子控件ListView
                child: childBuilder != null

                    ///如果还需要再自定义
                    ? childBuilder(context, m1, child)

                    ///不需要自定义则使用上层child--ListView/GridView
                    : child);
          },
        );
}
