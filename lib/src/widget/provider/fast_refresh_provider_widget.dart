import 'package:flutter/widgets.dart';
import 'package:flutter_fast_lib/src/view_model/fast_refresh_view_model.dart';
import 'package:flutter_fast_lib/src/widget/provider/fast_refresh_list_provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///纯粹刷新的返回Model非List
///1、2021-12-03 08:53修改 appBar=>[appBarBuilder] floatingActionButton=>[floatingActionButtonBuilder] bottomNavigationBar=>[bottomNavigationBarBuilder]
class FastRefreshProviderWidget<A extends FastRefreshViewModel>
    extends FastRefreshListProviderWidget<A> {
  FastRefreshProviderWidget({
    Key? key,
    required A model,
    required Widget Function(BuildContext context, A model) childBuilder,
    Color? backgroundColor,
    Function(A)? onModelReady,
    PreferredSizeWidget? Function(BuildContext context, A model)? appBarBuilder,
    Widget? Function(BuildContext context, A)? floatingActionButtonBuilder,
    Widget? Function(BuildContext context, A)? bottomNavigationBarBuilder,
    RefreshIndicator Function(BuildContext context)? headerBuilder,
    Widget Function(BuildContext context, A model)? loadingBuilder,
    Widget Function(BuildContext context, A model)? emptyBuilder,
    Widget Function(BuildContext context, A model)? errorBuilder,
    Widget? Function(BuildContext context, A moder)? scrollBuilder,
  }) : super(
          key: key,
          model: model,
          childBuilder: (context, model, child) => childBuilder(context, model),
          backgroundColor: backgroundColor,
          appBarBuilder: appBarBuilder,
          floatingActionButtonBuilder: floatingActionButtonBuilder,
          bottomNavigationBarBuilder: bottomNavigationBarBuilder,
          onModelReady: onModelReady,
          headerBuilder: headerBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
          scrollBuilder: scrollBuilder,
        );
}
