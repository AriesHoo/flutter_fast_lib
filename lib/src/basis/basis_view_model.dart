import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/basis/basis_view_state.dart';
import 'package:flutter_fast_lib/src/basis/basis_view_state_error.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';

///基础ViewModel
class BasisViewModel with ChangeNotifier {
  ///是否销毁
  bool isDisposed = false;

  /// 当前的页面状态,默认为loading,可在viewModel的构造方法中指定;
  BasisViewState _viewState;

  /// 根据状态构造
  /// 子类可以在构造函数指定需要的页面状态
  BasisViewModel({BasisViewState? viewState})
      : _viewState = viewState ?? BasisViewState.success;

  BasisViewState get viewState => _viewState;

  BasisViewStateError? _viewStateError;

  BasisViewStateError? get viewStateError => _viewStateError;

  set viewState(BasisViewState viewState) {
    _viewState = viewState;

    ///状态改变通知页面刷新
    notifyListeners();
  }

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get loading => viewState == BasisViewState.loading;

  bool get success => viewState == BasisViewState.success;

  bool get empty => viewState == BasisViewState.empty;

  bool get error => viewState == BasisViewState.error;

  void setSuccess() {
    viewState = BasisViewState.success;
  }

  void setLoading() {
    viewState = BasisViewState.loading;
  }

  void setEmpty() {
    viewState = BasisViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stack) async {
    _viewStateError = await FastManager
        .getInstance()
        .networkMixin
        .handleError(
      viewModel: this,
      e: e,
      stackTrace: stack,
    );
    viewState = BasisViewState.error;
  }

  ///网络请求
  Future<dynamic> doNetwork({
    required Future<dynamic> doRequest,
    bool loading = false,
    Function(
        dynamic e,
        StackTrace? stackTrace,
        )?
    onError,
  }) async {
    if (loading) {
      setLoading();
    }
    try {
      return await doRequest;
    } catch (e, stack) {
      if (onError != null) {
        onError.call(e is DioException ? e.error : e, stack);
      } else {
        setError(e, stack);
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  @override
  void notifyListeners() {
    if (isDisposed) {
      return;
    }
    super.notifyListeners();
  }
}
