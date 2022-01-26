import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/model/web/web_model.dart';

///WebApp ViewModel
class WebViewModel extends FastListViewModel<WebModel> {
  @override
  Future<List<WebModel>> loadData() async {
    List<WebModel> list = [];
    list.add(WebModel("知乎", "https://www.zhihu.com"));
    list.add(WebModel("简书", "https://www.jianshu.com"));
    list.add(WebModel("小红书", "https://www.xiaohongshu.com"));

    list.add(WebModel("百度", "https://m.baidu.com"));
    list.add(
        WebModel("贴吧", "https://tieba.baidu.com/index/tbwise/feed"));
    list.add(WebModel("微博", "https://m.weibo.cn"));

    list.add(WebModel("斗鱼", "https://m.douyu.com"));
    list.add(WebModel("虎牙", "https://m.huya.com"));
    list.add(WebModel("喜马拉雅", "https://m.ximalaya.com"));

    list.add(WebModel("Bilibili", "https://m.bilibili.com/index.html"));
    list.add(WebModel("优酷", "https://www.youku.com"));
    list.add(WebModel("爱奇艺", "https://m.iqiyi.com"));

    list.add(WebModel("豆瓣", "https://m.douban.com"));
    list.add(WebModel("网易", "https://3g.163.com/touch/#/"));
    list.add(WebModel("淘票票",
        "https://h5.m.taopiaopiao.com/app/moviemain/pages/index/index.html"));

    list.add(WebModel("下厨房", "https://m.xiachufang.com"));
    list.add(WebModel("什么值得买", "https://m.smzdm.com"));
    list.add(WebModel("查快递", "https://m.kuaidi100.com"));
    return list;
  }
}
