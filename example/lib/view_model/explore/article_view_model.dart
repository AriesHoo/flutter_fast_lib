import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/mixin/fast_lib_mixin.dart';
import 'package:flutter_fast_lib_example/model/explore/article_model.dart';

///获取文章ViewModel
class ArticleViewModel extends FastRefreshListViewModel<ArticleItemModel> {
  ///最近新闻游标
  String lastCursor = '';
  String url;

  ArticleViewModel({required this.url});

  @override
  Future<List<ArticleItemModel>> loadData({int pageNum = 0}) async {
    ///第一页将游标重置
    lastCursor =
        pageNum == fastLibMixin.pageNumFirst
            ? ''
            : lastCursor;
    ArticleModel model = await FastNetwork.getInstance()
        .get(
            'https://api.readhub.cn/$url?lastCursor=$lastCursor&pageSize=$pageSize')
        .then((value) => ArticleModel.fromJson(value.data));
    lastCursor = model.getLastCursor();
    // FastLogUtil.e('pageNum$pageNum', tag: 'ArticleViewModel');
    return model.data != null ? model.data! : [];
  }

  ///预刷新--该方式非100%准确,只适用于一段时间(这段时间最多更新20条新资讯)
  preRefresh() async {
    ArticleModel model = await FastNetwork.getInstance()
        .get(
            'https://api.readhub.cn/$url?pageSize=$pageSize')
        .then((value) => ArticleModel.fromJson(value.data));
    if (model.data != null && model.data!.isNotEmpty) {
      List<ArticleItemModel> listData = model.data!.toList();

      ///移除已经存在的
      model.data!.removeWhere(
          (element) => list.any((itemList) => itemList.id == element.id));

      ///有新的资讯
      if (model.data!.isNotEmpty) {
        ///移除当前list与返回重复资讯
        list.removeWhere(
            (element) => listData.any((itemData) => itemData.id == element.id));

        ///将新获取资讯添加到list顶部
        listData.addAll(list);
        list = listData;

        FastToastUtil.showSuccess(
          '发现${model.data!.length}条新${getLabel()}',
        );
      }

      ///至少刷新新闻发布时间间隔
      setSuccess();
      FastLogUtil.v('length:${model.data!.length};listLength:${list.length}'
          ';listData_length:${listData.length}');
    }
  }

  String getLabel() {
    String result = '讯息';
    switch (url) {

      ///热门话题
      case 'topic':
        result = '话题';
        break;

      ///科技动态
      case 'news':
        result = '动态';
        break;

      ///技术资讯
      case 'technews':
        result = '资讯';
        break;
    }
    return result;
  }
}
