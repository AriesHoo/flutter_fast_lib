import 'dart:async';

import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_blood_belfry/constant/app_constant.dart';
import 'package:flutter_blood_belfry/data/api_interceptor.dart';
import 'package:flutter_blood_belfry/data/common_repository.dart';
import 'package:flutter_blood_belfry/helper/network_helper.dart';
import 'package:flutter_blood_belfry/main.dart';
import 'package:flutter_blood_belfry/util/auto_size_util.dart';
import 'package:flutter_blood_belfry/widget/windmill_indicator.dart';

///统一配置
FastLibMixin fastLibMixin = FastLibMixin();

///重写FastLib 配置
class FastLibMixin extends DefaultFastLibMixin {
  ///网络请求基地址
  @override
  String get baseUrl => AppConstant.apiUrl;

  ///单个拦截器
  @override
  Interceptor get interceptor => ApiInterceptor();

  ///日志打印拦截器
  @override
  FastLogInterceptor get logInterceptor => FastLogInterceptor(
        debug: AppConstant.isTest,
        tag: '${tag}_FastLogInterceptor',
        responseBody: AppConstant.isTest,
        requestBody: AppConstant.isTest,
      );

  @override
  bool get debug => AppConstant.isTest;

  @override
  String get tag => 'teachCloud';

  @override
  int get pageNumFirst => 1;

  ///配合 1 2 3 4列 取最小公倍数
  @override
  int get pageSize => 24;

  ///滚动到顶部阈值
  @override
  double get scrollTopThreshold => 1000;

  ///下拉刷新header
  @override
  RefreshIndicator headerBuilder(BuildContext context) {
    return CustomHeader(
      builder: (context, state) => const Center(
        child: WindmillIndicator.medium(),
      ),
      refreshStyle: RefreshStyle.Follow,
      height: 32.0,
    );
  }

  ///刷新脚-加载中
  @override
  Widget footerLoadingBuilder(BuildContext context) =>
      const WindmillIndicator.small();

  TextStyle get messageStyle =>
      Theme.of(currentContext).textTheme.subtitle1!.copyWith(
            fontSize: getFontSize(14),
          );

  ///加载中-获取数据
  @override
  Widget loadingBuilder(BuildContext context, FastListViewModel model) {
    return const FastLoadingStateWidget(
      loading: WindmillIndicator.medium(),
    );
  }

  @override
  Widget emptyBuilder(BuildContext context, FastListViewModel model) {
    return Theme(
      data: Theme.of(context),
      child: FastStateWidget(
        message: Text(
          appString.viewStateEmpty,
          style: messageStyle,
        ),
        onPressed: () => model.initData(),
      ),
    );
  }

  @override
  Widget errorBuilder(BuildContext context, FastListViewModel model) {
    String? errorMessage = model.viewStateError?.errorMessage;
    return Theme(
      data: Theme.of(context),
      child: FastStateWidget(
        message: Text(
          '$errorMessage',
          style: messageStyle,
        ),
        onPressed: () => model.initData(),
      ),
    );
  }

  @override
  Widget itemBuilder(
    BuildContext context,
    FastListViewModel model,
    int index,
    Widget Function(BuildContext context, FastListViewModel model, int index)
        itemBuilder,
  ) {
    return Theme(
        data: Theme.of(context),
        child: super.itemBuilder(context, model, index, itemBuilder));
  }

  @override
  Future<BasisViewStateError> handleError({
    required BasisViewModel viewModel,
    dynamic e,
    StackTrace? stackTrace,
  }) async {
    BasisErrorType errorType = BasisErrorType.network;
    String errorMessage = '$e';
    FastLogUtil.e('e:$e;stack:$stackTrace', tag: 'handleError');

    ///显示toast
    bool toast = true;
    if (e is DioError) {
      FastLogUtil.e('e:${e.type};message:${e.message}', tag: 'handleErrorTag');
      errorMessage = e.message;
      e = e.error;
      errorType = e is FastTokenException || e is FastFailedException
          ? BasisErrorType.normal
          : BasisErrorType.network;

      ///token过期
      if (e is FastTokenException) {
        toast = false;

        ///链接后台返回明确错误信息
      } else if (e is FastFailedException) {
        errorType = BasisErrorType.normal;
        errorMessage = '${e.message}';

        ///链接不不上服务器-包括用户直接网络不好或者服务崩溃(服务未启动)
        ///服务器崩溃(服务未启动) e.message为空 用户无网络 Connection failed
      } else {
        String error = e.toString();
        error = error.substring(error.indexOf('[') + 1, error.length - 1);
        errorMessage = appString.httpErrorMessage;

        ///服务器宕机
        if (error.toLowerCase().contains('502') ||
            error.toLowerCase().contains('gateway')) {
          errorMessage = appString.httpServiceErrorMessage;
        }

        ///提示不可访问云平台--判断是无法上网还是云平台问题
        if (appString.httpErrorMessage == errorMessage) {
          bool enable = await CommonRepository.checkNetwork();

          ///能上外网则说明网络通畅为服务器问题(接口无法访问)
          if (enable) {
            errorMessage = appString.httpServiceErrorMessage;
          }
        } else {
          FastToastUtil.showError(errorMessage);
        }
        FastLogUtil.d(
            'e:$e;isTimeoutException:${e is HttpException}'
            ';isWifi:${NetworkHelper.getInstance().isWifi}'
            ';isMobile:${NetworkHelper.getInstance().isMobile}'
            ';error:${e.toString()}',
            tag: 'handleErrorTag');
      }
    }

    ///显示toast-list直接在error
    if (toast && viewModel is! FastListViewModel) {
      FastLogUtil.e('handleError_showToast:$errorMessage');
      FastToastUtil.showError(errorMessage);
    }
    return BasisViewStateError(errorType, message: errorMessage, error: e);
  }

  @override
  Widget get loadingWidget => const WindmillIndicator();

  @override
  bool get notification => isSmallDisplay;

  @override
  EdgeInsets? get defaultContentPadding => const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 12,
      );

  @override
  String get closeButtonTooltip => appString.close;

  @override
  bool get scrollTopExtended => true;
}
