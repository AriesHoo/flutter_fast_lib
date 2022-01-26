import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/main.dart';
import 'package:flutter_fast_lib_example/view_model/web/web_view_model.dart';
import 'package:flutter_fast_lib_example/web_view_page.dart';
import 'package:flutter_fast_lib_example/widget/highlight_card_widget.dart';

///WebApp演示
class TabWeb extends StatelessWidget {
  const TabWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width ~/ 120;
    return FastListProviderWidget<WebViewModel>(
      appBarBuilder: (context, model) => AppBar(
        title: Text(appString.tabWeb),
      ),
      model: WebViewModel(),
      childBuilder: (context, model,child) => GridView.builder(
        // controller: model.scrollTopController.scrollController,
        addAutomaticKeepAlives: true,
        physics: const ClampingScrollPhysics(),
        itemCount: model.list.length,
        cacheExtent: 500,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          ///交叉轴数
          crossAxisCount: crossAxisCount,

          ///主轴单个子Widget之间间距
          mainAxisSpacing: 0.0,

          ///交叉轴单个子Widget之间间距
          crossAxisSpacing: 0.0,
          mainAxisExtent: 80,
        ),
        itemBuilder: (context, index) => HighlightCard(
          margin: 8,
          marginHighlight: 4,
          builder: (context, highlight) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(model.list[index].name)],
          ),
          onTap: () => WebViewPage.start(initialUrl: model.list[index].url),
        ),
      ),
    );
  }
}
