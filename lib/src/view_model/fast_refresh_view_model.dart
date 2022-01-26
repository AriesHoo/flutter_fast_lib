import 'package:flutter_fast_lib/src/view_model/fast_refresh_list_view_model.dart';

///可下拉刷新单model
/// 1、修改[data]返回值--因为在[BasisViewState.success]状态才会去获取数据故去掉null的情况;故开发者注意调用时机
abstract class FastRefreshViewModel<T> extends FastRefreshListViewModel<T> {
  ///单个则无须加载更多
  @override
  bool get enablePullUp => false;

  @override
  int get pageSize => 10;

  T get data => list[0];

  @override
  Future<List<T>> loadData({
    int pageNum = 0,
  }) async {
    return [await loadModelData()];
  }

  /// 加载数据
  Future<T> loadModelData();
}
