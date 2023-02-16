import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/basis/basis_provider_widget.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/view_model/fast_list_view_model.dart';
import 'package:flutter_fast_lib/src/widget/provider/fast_refresh_list_provider_widget.dart';

///获取单个list列表--无须下拉刷新及上拉加载更多--这种适用于item数量很少
///如需要则使用[FastRefreshListProviderWidget]
///1、2021-11-15 09:23 去掉child相关参数配置
///2、2021-12-03 08:53修改 appBar=>[appBarBuilder] floatingActionButton=>[floatingActionButtonBuilder] bottomNavigationBar=>[bottomNavigationBarBuilder]
///3、2022-01-06 09:37增加[backgroundColor] 用于设置[Scaffold]背景色
class FastListProviderWidget<A extends FastListViewModel>
    extends BasisProviderWidget<A> {
  FastListProviderWidget({
    Key? key,
    required A model,
    bool inScaffold = true,
    bool? resizeToAvoidBottomInset,
    Key? scaffoldKey,
    SliverGridDelegate? gridDelegate,
    Axis scrollDirection = Axis.vertical,
    double? itemExtent,
    double? cacheExtent,
    Color? backgroundColor,
    Function(A)? onModelReady,
    PreferredSizeWidget? Function(BuildContext context, A model)? appBarBuilder,
    Widget? Function(BuildContext context, A)? drawerBuilder,
    Widget? Function(BuildContext context, A)? endDrawerBuilder,
    Widget? Function(BuildContext context, A)? floatingActionButtonBuilder,
    Widget? Function(BuildContext context, A)? bottomNavigationBarBuilder,
    Widget Function(BuildContext context, A model, int index)? itemBuilder,
    Widget Function(BuildContext context, A model, Widget? child)? childBuilder,
    Widget Function(BuildContext context, A model)? loadingBuilder,
    Widget Function(BuildContext context, A model)? emptyBuilder,
    Widget Function(BuildContext context, A model)? errorBuilder,
    Widget? Function(BuildContext context, A moder)? scrollBuilder,
    bool Function(BuildContext context, A model, int index)? safeItemBottom,
  })
      : assert(itemBuilder != null || childBuilder != null,
  'You should specify either a itemBuilder or a childBuilder'),
        super(
          key: key,
          model: model,
          onModelReady: (m1) {
            model.initData();

            ///初始化滚动监听
            m1.scrollTopController.initListener();
            onModelReady?.call(model);
          },
          builder: (context, m1, child) {
            Widget? body;
            if (m1.loading) {
              body = loadingBuilder != null
                  ? loadingBuilder(context, m1)
                  : FastManager
                  .getInstance()
                  .refreshListMixin
                  .loadingBuilder(context, m1);
            } else if (m1.empty) {
              body = emptyBuilder != null
                  ? emptyBuilder(context, m1)
                  : FastManager
                  .getInstance()
                  .refreshListMixin
                  .emptyBuilder(context, m1);
            } else if (m1.error && ObjectUtil.isEmpty(m1.list)) {
              body = errorBuilder != null
                  ? errorBuilder(context, m1)
                  : FastManager
                  .getInstance()
                  .refreshListMixin
                  .errorBuilder(context, m1);
            }

            ///回到顶部
            Widget? scroll = scrollBuilder != null
                ? scrollBuilder(context, m1)
                : FastManager
                .getInstance()
                .refreshListMixin
                .scrollTopBuilder(context, m1);

            ///floatingActionButton
            Widget? floatingActionButton = floatingActionButtonBuilder != null
                ? floatingActionButtonBuilder(context, m1)
                : null;

            ///列表组件
            Widget _child = gridDelegate != null
                ? GridView.builder(
              gridDelegate: gridDelegate,
              cacheExtent: cacheExtent,
              scrollDirection: scrollDirection,
              controller: m1.scrollTopController.scrollController,
              primary: false,
              itemCount: m1.list.length,
              itemBuilder: (context, index) {
                Widget itemWidget = itemBuilder != null
                    ? FastManager
                    .getInstance()
                    .refreshListMixin
                    .itemBuilder(
                  context,
                  m1,
                  index,
                      (c, m, i) => itemBuilder(c, m as A, i),
                )
                    : const SizedBox();
                return itemWidget;
              },
            )
                : ListView.builder(

              ///滚动监听-用于控制直达顶部功能
              controller: m1.scrollTopController.scrollController,

              ///内容适配
              shrinkWrap: true,
              scrollDirection: scrollDirection,

              ///在列表元素不可见后可以保持元素的状态-空间换时间可设置false
              addAutomaticKeepAlives: true,
              physics: const ClampingScrollPhysics(),
              itemCount: m1.list.length,
              itemBuilder: (context, index) {
                Widget itemWidget = itemBuilder != null
                    ? FastManager
                    .getInstance()
                    .refreshListMixin
                    .itemBuilder(
                  context,
                  m1,
                  index,
                      (c, m, i) => itemBuilder(c, m as A, i),
                )
                    : const SizedBox();

                ///最后item是否做safeArea操作-避免被刘海区域遮住
                bool safeItem = false;
                if (safeItemBottom != null) {
                  safeItem = safeItemBottom(context, m1, index);
                } else {
                  safeItem = FastManager
                      .getInstance()
                      .refreshListMixin
                      .safeItemBottom(context, model, index);
                }

                ///只有最后一个item做safeArea操作
                safeItem = safeItem && index == m1.list.length - 1;
                return safeItem
                    ? Padding(
                  child: itemWidget,

                  ///获取距离底部padding
                  padding: EdgeInsets.only(
                    bottom: MediaQueryData
                        .fromWindow(window)
                        .padding
                        .bottom,
                  ),
                )
                    : itemWidget;
              },
            );
            Widget _kid = body ??
                (childBuilder != null

                ///将通用列表组件回传回去方便复用--如果需要的话
                    ? childBuilder(context, m1, _child)
                    : _child);
            if (!inScaffold) {
              return _kid;
            }

            ///页面展示
            return Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              drawer: drawerBuilder?.call(context, m1),
              endDrawer: endDrawerBuilder?.call(context, m1),
              appBar:
              appBarBuilder != null ? appBarBuilder(context, m1) : null,
              backgroundColor: backgroundColor,

              ///决定最终展示body
              body: _kid,
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  scroll ?? const SizedBox(),
                  SizedBox(
                    height: floatingActionButton != null ? 16 : 0,
                  ),
                  floatingActionButton ?? const SizedBox(),
                ],
              ),
              bottomNavigationBar: bottomNavigationBarBuilder != null
                  ? bottomNavigationBarBuilder(context, m1)
                  : null,
            );
          });
}
