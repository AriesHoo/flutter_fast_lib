import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_fast_lib/src/basis/basis_scroll_top_controller.dart';
import 'package:flutter_fast_lib/src/basis/basis_view_model.dart';

/// 一次性获取列表数据
abstract class FastListViewModel<T> extends BasisViewModel {
  ///ScrollController用于控制滚动逻辑
  BasisScrollTopController scrollTopController =
  BasisScrollTopController.defaultTopController();

  /// 页面数据
  List<T> list = [];

  /// 第一次进入页面
  void initData() async {
    setLoading();
    refresh(init: true);
  }

  /// 下拉刷新
  void refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (ObjectUtil.isEmpty(data)) {
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setSuccess();
      }
    } catch (e, stack) {
      if (init) list.clear();
      setError(e, stack);
    }
  }

  /// 加载数据
  Future<List<T>> loadData();

  void onCompleted(List<T> data) {}
}
