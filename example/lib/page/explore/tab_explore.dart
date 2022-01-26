import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/model/explore/article_model.dart';
import 'package:flutter_fast_lib_example/view_model/explore/article_view_model.dart';
import 'package:flutter_fast_lib_example/web_view_page.dart';
import 'package:flutter_fast_lib_example/widget/highlight_card_widget.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

///
class TabExplore extends StatelessWidget {
  final String url;
  final bool showAppBar;
  final Function(ArticleViewModel)? onModelReady;

  const TabExplore({
    Key? key,
    required this.url,
    this.showAppBar = false,
    this.onModelReady,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FastLogUtil.e('build', tag: 'TabExploreTag');
    return FastListProviderWidget<ArticleViewModel>(
      model: ArticleViewModel(url: url),
      onModelReady: onModelReady,
      appBarBuilder: (context, model) => showAppBar
          ? AppBar(
              title: Text('ArticleList_$url'),
            )
          : null,
      // itemExtent: 180,
      // footerSafeArea: !showAppBar,
      loadingBuilder: (context, model) => SingleChildScrollView(
        child: SkeletonLoader(
          builder: HighlightCardWidget(
            showBorder: true,
            builder: (context, model) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Container(
                width: double.infinity,
                height: 160,
                color: Colors.orange,
              ),
            ),
          ),
          items: 20,
          period: const Duration(milliseconds: 2500),
          highlightColor: Theme.of(context).colorScheme.primary,
          baseColor: Colors.black.withOpacity(0.1),
          direction: SkeletonDirection.ltr,
        ),
      ),
      itemBuilder: (context, model, index) => ArticleAdapter(
        item: model.list[index],
      ),
      // childBuilder: (context, model, child) => ListView.builder(
      //   itemCount: model.list.length,
      //   itemBuilder: (context, index) => ArticleAdapter(
      //     item: model.list[index],
      //   ),
      // ),
    );
  }
}

///文章适配器
class ArticleAdapter extends StatelessWidget {
  const ArticleAdapter({
    Key? key,
    required this.item,
    this.showBorder = true,
  }) : super(key: key);
  final ArticleItemModel item;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Container(
      height: 180,
      padding: const EdgeInsets.only(top: 12),
      margin: const EdgeInsets.symmetric(horizontal: 12),

      ///分割线
      // decoration: BoxDecoration(
      //   border: DecorationUtil.lineBoxBorder(
      //     context,
      //     bottom: showBorder,
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ///标题
          Text(
            '${item.title}',
            textScaleFactor: 1,
            maxLines: 1,
            strutStyle: const StrutStyle(
              forceStrutHeight: false,
              height: 0.5,
              leading: 1,
            ),

            ///浏览器...显示异常
            overflow: FastPlatformUtil.isWeb
                ? TextOverflow.fade
                : TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(
            height: 6,
          ),

          ///描述摘要
          Expanded(
            flex: 1,
            child: Text(
              item.getSummary(),
              textScaleFactor: 1,
              maxLines: FastPlatformUtil.isMobile
                  ? item.maxLine
                      ? 3
                      : 10000
                  : 3,

              ///浏览器...显示异常
              overflow: FastPlatformUtil.isWeb
                  ? TextOverflow.fade
                  : TextOverflow.ellipsis,
              strutStyle: const StrutStyle(
                forceStrutHeight: false,
                height: 0.5,
                leading: 1,
              ),
              style: Theme.of(context).textTheme.caption!.copyWith(
                  letterSpacing: 1,
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.8)),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  item.getTimeStr(),
                  textScaleFactor: 1,
                  maxLines: 2,

                  ///浏览器...显示异常
                  overflow: FastPlatformUtil.isWeb
                      ? TextOverflow.fade
                      : TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),

              ///分享
              SmallButtonWidget(
                onTap: () => _onLongPress(context),
                tooltip: 'share',
                child: const Icon(
                  Icons.share,
                  size: 20,
                ),
              ),

              ///查看详情web
              SmallButtonWidget(
                onTap: _onClick,
                tooltip: 'openDetail',
                child: const Icon(Icons.remove_red_eye),
              ),
            ],
          ),
        ],
      ),
    );

    ///外层Material包裹以便按下水波纹效果
    return Material(
      color: Theme.of(context).cardColor,
      child: HighlightCardWidget(
        ///Container 包裹以便设置padding margin及边界线
        builder: (context, model) => childWidget,
        showBorder: showBorder,
        onLongPress: () => _onLongPress(context),
        onTap: _onClick,
      ),
    );
  }

  _onClick() {
    WebViewPage.start(initialUrl: item.getUrl());
  }

  ///长按
  _onLongPress(BuildContext context) {
    FastToastUtil.showWarning('onLongPress');
  }
}

///ArticleAdapter 打开连接及关联报道Button
class SmallButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;
  final String tooltip;

  const SmallButtonWidget({
    Key? key,
    required this.onTap,
    required this.child,
    required this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}
