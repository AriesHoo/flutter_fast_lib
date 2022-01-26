import 'package:common_utils/common_utils.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/view_model/fast_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 下拉刷新及上拉加载更多封装
abstract class FastRefreshListViewModel<T> extends FastListViewModel<T> {
  /// 分页第一页页码
  int pageNumFirst = FastManager
      .getInstance()
      .refreshListMixin
      .pageNumFirst;

  /// 分页条目数量
  int pageSize = FastManager
      .getInstance()
      .refreshListMixin
      .pageSize;

  /// 当前页码
  int _currentPage = 0;

  int get currentPage => _currentPage;

  ///设置当前页码
  setCurrentPage(int value) {
    _currentPage = value;
  }

  ///下拉刷新controller
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  ///是否可下拉
  bool _enablePullDown = true;

  bool get enablePullDown => _enablePullDown;

  setEnablePullDown(bool value) {
    _enablePullDown = value;
  }

  ///是否可上拉
  bool _enablePullUp = true;

  bool get enablePullUp => _enablePullUp;

  setEnablePullUp(bool value) {
    _enablePullUp = value;
  }

  /// 下拉刷新
  @override
  void refresh({bool init = false}) async {
    ///首次进入-设置当前页码
    if (init || refreshController.isRefresh) {
      setCurrentPage(pageNumFirst);
    }
    FastManager
        .getInstance()
        .refreshListMixin
        .requestData(this, refreshController);
  }

  /// 上拉加载更多
  loadMore() async {
    setCurrentPage(currentPage + 1);
    FastManager
        .getInstance()
        .refreshListMixin
        .requestData(this, refreshController);
  }

  ///自动调用刷新功能
  autoRefresh({
    bool request = true,
  }) {
    ///无数据模拟点击loading
    if (ObjectUtil.isEmpty(list) || !request) {
      initData();
    } else {
      refreshController.requestRefresh();
    }
  }

  /// 加载数据
  @override
  Future<List<T>> loadData({int pageNum = 0});

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
