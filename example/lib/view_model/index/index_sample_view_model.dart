import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/manager/router_manger.dart';
import 'package:flutter_fast_lib_example/model/index/index_sample_model.dart';

/// 主页示例ViewModel
class IndexSampleViewModel extends FastRefreshListViewModel<IndexSampleModel> {
  @override
  Future<List<IndexSampleModel>> loadData({int pageNum = 0}) async {
    List<IndexSampleModel> listData = [];
    listData.add(IndexSampleModel(
      title: 'FasTabBar演示',
      routeName: RouteName.fastTabBarPage,
    ));
    listData.add(IndexSampleModel(
      title: 'QQ渐变TitleBar',
      routeName: RouteName.qqTitleBarPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastToastUtil演示',
      routeName: RouteName.fastToastPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastDialog演示',
      routeName: RouteName.fastDialogPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastLoadingUtil演示',
      routeName: RouteName.fastLoadingPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastSpUtil演示',
      routeName: RouteName.fastSpPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastMethodChannelUtil演示',
      routeName: RouteName.fastChannelPage,
    ));
    listData.add(IndexSampleModel(
      title: 'FastDialogUtil演示',
      routeName: RouteName.fastDialogUtilPage,
    ));
    return listData;
  }
}
