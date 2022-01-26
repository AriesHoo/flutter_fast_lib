import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_fast_lib/src/util/fast_log_util.dart';
import 'package:flutter_fast_lib/src/util/fast_platform_util.dart';
import 'package:flutter_fast_lib/src/view_model/fast_list_view_model.dart';
import 'package:flutter_fast_lib/src/view_model/fast_refresh_list_view_model.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_empty_state_widget.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_error_state_widget.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_loading_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///[FastRefreshListViewModel]对应参数配置
/// 空布局、错误布局、加载中布局
/// 1、2022-01-07 09:27 增加onModelReady前处理逻辑[onBeforeModelReady]
///                     主要为滚动底部自动加载下一页判断逻辑--为非手机端运行增加运行手机端(包括web运行手机端)滚动底部监听很好
mixin FastRefreshListMixin {
  ///初始页码
  int get pageNumFirst => 0;

  ///默认每页数量
  int get pageSize => 20;

  ///脚Widget高度
  double get footerHeight => 50;

  ///脚Widget 底部安全区域
  bool get footerSafeArea => true;

  ///[LoadStatus.idle]
  String get loadStatusIdle => '点击加载更多';

  ///[LoadStatus.canLoading]
  String get loadStatusCanLoading => loadStatusIdle;

  ///[LoadStatus.loading]
  String get loadStatusLoading => '加载中...';

  ///[LoadStatus.noMore]
  String get loadStatusNoMore => '无更多数据';

  ///[LoadStatus.failed]
  String get loadStatusFailed => '加载失败';

  ///[FastRefreshListMixin]
  String get tooltipScrollTop => '回到顶部';

  ///显示回到顶部Icon
  Widget? get scrollTopIcon => null;

  ///显示回到顶部阈值
  double get scrollTopThreshold => 1000;

  ///是否使用FloatingActionButton.extended
  bool get scrollTopExtended => false;

  ///统一刷新头
  RefreshIndicator headerBuilder(BuildContext context) =>
      FastPlatformUtil.isAndroid
          ? MaterialClassicHeader(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: Theme.of(context).colorScheme.primary,
            )
          : ClassicHeader(
              ///文字样式
              textStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              refreshingIcon: !FastPlatformUtil.isAndroid
                  ? const CupertinoActivityIndicator()
                  : const SizedBox(
                      width: 18.0,
                      height: 18.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
            );

  ///footerIdle默认状态Widget
  Widget footerIdleBuilder(BuildContext context) {
    return Text(
      loadStatusIdle,
      style: Theme.of(context).textTheme.caption,
    );
  }

  ///footerCanLoading状态Widget
  Widget footerCanLoadingBuilder(BuildContext context) {
    return Text(
      loadStatusCanLoading,
      style: Theme.of(context).textTheme.caption,
    );
  }

  ///footerLoading状态Widget
  Widget footerLoadingBuilder(BuildContext context) {
    return const CupertinoActivityIndicator();
  }

  ///footerNoMore状态Widget
  Widget footerNoMoreBuilder(BuildContext context) {
    return Text(
      loadStatusNoMore,
      style: Theme.of(context).textTheme.caption,
    );
  }

  ///footerFailed状态Widget
  Widget footerFailedBuilder(BuildContext context) {
    return Text(
      loadStatusFailed,
      style: Theme.of(context).textTheme.caption,
    );
  }

  ///统一刷新脚
  LoadIndicator footerBuilder(RefreshController controller, bool? footerSafe) {
    bool safe = footerSafe ?? footerSafeArea;
    double safeBottomHeight =
        safe ? MediaQueryData.fromWindow(window).padding.bottom : 0;
    return CustomFooter(
      height: footerHeight + safeBottomHeight,
      onClick: () => controller.requestLoading(),
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = footerIdleBuilder(context);
        } else if (mode == LoadStatus.canLoading) {
          body = footerCanLoadingBuilder(context);
        } else if (mode == LoadStatus.loading) {
          body = footerLoadingBuilder(context);
        } else if (mode == LoadStatus.noMore) {
          body = footerNoMoreBuilder(context);
        } else {
          body = footerFailedBuilder(context);
        }
        return Container(
          height: footerHeight + safeBottomHeight,
          padding: EdgeInsets.only(
            bottom: safeBottomHeight,
          ),
          child: Center(
            child: body,
          ),
        );
      },
    );
  }

  ///item构造器
  Widget itemBuilder(
    BuildContext context,
    FastListViewModel model,
    int index,
    Widget Function(
      BuildContext context,
      FastListViewModel model,
      int index,
    )
        itemBuilder,
  ) {
    return itemBuilder(context, model, index);
  }

  ///加载中
  Widget loadingBuilder(BuildContext context, FastListViewModel model) =>
      const FastLoadingStateWidget();

  ///空布局
  Widget emptyBuilder(BuildContext context, FastListViewModel model) =>
      FastEmptyStateWidget(
        onPressed: () => model.initData(),
      );

  ///错误布局
  Widget errorBuilder(BuildContext context, FastListViewModel model) =>
      FastErrorStateWidget(
        message: model.viewStateError?.message,
        onPressed: () => model.initData(),
      );

  ///滚动顶部Widget
  Widget? scrollTopBuilder(BuildContext context, FastListViewModel model) =>
      ValueListenableBuilder<bool>(
        valueListenable: model.scrollTopController.scrollWidgetNotifier,
        builder: (context, show, child) {
          return show
              ? scrollTopExtended
                  ? FloatingActionButton.extended(
                      heroTag: null,
                      label: Text(tooltipScrollTop),
                      icon: scrollTopIcon ??
                          const Icon(
                            Icons.file_upload,
                          ),
                      onPressed: () {
                        model.scrollTopController.scrollTo();
                      },
                    )
                  : FloatingActionButton(
                      heroTag: null,
                      tooltip: tooltipScrollTop,
                      child: scrollTopIcon ??
                          const Icon(
                            Icons.file_upload,
                          ),
                      onPressed: () {
                        model.scrollTopController.scrollTo();
                      },
                    )
              : const SizedBox();
        },
      );

  ///是否item设置安全区域效果
  bool safeItemBottom(
          BuildContext context, FastListViewModel model, int index) =>
      true;

  ///请求数据--下拉刷新及上拉加载更多
  requestData(
    FastRefreshListViewModel refreshListViewModel,
    RefreshController refreshController,
  ) async {
    ///当前为下拉刷新
    bool isRefresh = refreshController.isRefresh;

    ///当前加载页码
    int current = refreshListViewModel.currentPage;

    ///初次进入页码-第一次加载
    isRefresh = isRefresh || current == refreshListViewModel.pageNumFirst;
    try {
      FastLogUtil.e('FastRefreshListMixin_start_current:$current');
      var data = await refreshListViewModel.loadData(pageNum: current);

      ///无数据
      if (ObjectUtil.isEmpty(data)) {
        if (isRefresh) {
          refreshController.refreshCompleted(resetFooterState: true);
          refreshListViewModel.list.clear();
          refreshListViewModel.setEmpty();
        } else {
          current--;
          refreshController.loadNoData();
          refreshListViewModel.setEnablePullUp(false);
        }
      } else {
        refreshListViewModel.onCompleted(data);
        if (isRefresh) {
          refreshListViewModel.list.clear();
        }
        refreshListViewModel.list.addAll(data);
        refreshController.refreshCompleted();

        /// 小于分页的数量,禁止上拉加载更多
        if (data.length < refreshListViewModel.pageSize) {
          refreshController.loadNoData();
          refreshListViewModel.setEnablePullUp(false);
        } else {
          ///防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
          refreshListViewModel.setEnablePullUp(true);
        }
        refreshListViewModel.setSuccess();
      }
    } catch (e, stack) {
      ///当前下拉刷新
      if (isRefresh) {
        ///此处不做清空数据处理
        refreshController.refreshFailed();
      } else {
        current--;
        refreshController.loadFailed();
      }
      refreshListViewModel.setError(e, stack);
    }
    refreshListViewModel.setCurrentPage(current);
    FastLogUtil.e('FastRefreshListMixin_end_current:$current');
  }

  ///增加[onModelReady]前置处理逻辑
  void onBeforeModelReady(FastRefreshListViewModel listViewModel) {
    ScrollController scrollController =
        listViewModel.scrollTopController.scrollController;
    RefreshController refreshController = listViewModel.refreshController;
    scrollController.addListener(
      () {
        ///监听滚动到底部
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          ///此处主要为实现更新底部loadingUI及触发加载更多回调使用
          ///footerMode?.value 设置加载状态形式不使用requestLoading()
          ///非手机端requestLoading()测试正常 手机端会异常
          ///非加载中且非下拉刷新且非无更多数据
          if (!refreshController.isLoading &&
              !refreshController.isRefresh &&
              LoadStatus.noMore != refreshController.footerStatus) {
            refreshController.footerMode?.value = LoadStatus.loading;
          }
        }
      },
    );
  }
}
