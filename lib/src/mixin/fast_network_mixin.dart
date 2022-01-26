import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fast_lib/src/basis/basis_error_type.dart';
import 'package:flutter_fast_lib/src/basis/basis_view_model.dart';
import 'package:flutter_fast_lib/src/basis/basis_view_state_error.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/network/fast_log_interceptor.dart';
import 'package:flutter_fast_lib/src/util/fast_loading_util.dart';

///网络请求[FastNetwork]参数配置
///请求异常处理[handleError]
///请求前及后处理(用于添加loading效果)
mixin FastNetworkMixin {
  ///基地址
  String get baseUrl => '';

  ///响应数据类型
  ResponseType get responseType => ResponseType.json;

  ///Content-Type
  String get contentType => Headers.jsonContentType;

  ///请求头
  Map<String, dynamic>? get headers => null;

  ///连接超时-连接超时10s足够确认是否能连接上
  int? get connectTimeout => 10 * 1000;

  ///接收超时-文件下载
  int? get receiveTimeout => 60 * 1000;

  ///发送超时-文件上传
  int? get sendTimeout => 60 * 1000;

  ///日志拦截器
  FastLogInterceptor? get logInterceptor => FastLogInterceptor(
        debug: FastManager.getInstance().logMixin.debug,
        tag: '${FastManager.getInstance().logMixin.tag}_FastLogInterceptor',
      );

  ///单个拦截器
  Interceptor? get interceptor => null;

  ///拦截器组
  Iterable<Interceptor>? get interceptors => null;

  ///加载中loading
  Widget? get networkLoadingWidget =>
      FastManager.getInstance().loadingMixin.loadingWidget;

  ///加载中文本信息
  String? get networkLoadingText =>
      FastManager.getInstance().loadingMixin.loadingText;

  ///加载中文本信息样式
  TextStyle? get networkLoadingTextStyle =>
      FastManager.getInstance().loadingMixin.loadingTextStyle;

  ///处理异常
  Future<BasisViewStateError> handleError({
    required BasisViewModel viewModel,
    dynamic e,
    StackTrace? stackTrace,
  }) async {
    return BasisViewStateError(BasisErrorType.normal);
  }

  ///开启loading效果
  dynamic doLoadingStart({
    Widget? loading,
    TextStyle? messageStyle,
    String? messageText,
    CancelToken? cancelToken,
    bool canceledOnTouchOutside = true,
  }) {
    return FastLoadingUtil.showLoading(
      crossPage: false,
      clickClose: canceledOnTouchOutside,
      backButtonBehavior: BackButtonBehavior.close,
      builder: (_) =>
          FastManager.getInstance().loadingMixin.loadingWidgetBuilder(
                _,
                loading ?? networkLoadingWidget,
                messageText ?? networkLoadingText,
                messageStyle ?? networkLoadingTextStyle,
              ),
    );
  }

  ///结束loading效果
  doLoadingFinish({
    dynamic func,
  }) {
    if (func is CancelFunc) {
      FastLoadingUtil.hideLoading(cancelFunc: func);
    }
  }
}
