import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/view_model/index/index_sample_view_model.dart';
import 'package:flutter_fast_lib_example/widget/highlight_card_widget.dart';

///主页tab*[FastMainPage]
class TabIndex extends StatefulWidget {
  const TabIndex({Key? key}) : super(key: key);

  @override
  _TabIndexState createState() => _TabIndexState();
}

class _TabIndexState extends State<TabIndex> {
  @override
  Widget build(BuildContext context) {
    return FastListProviderWidget<IndexSampleViewModel>(
      model: IndexSampleViewModel(),
      childBuilder: (context, model,child) => CustomScrollView(
        ///用于监控滚动
        controller: model.scrollTopController.scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => HighlightCardWidget(
                showBorder: true,
                builder: (context, highlight) => ListTile(
                  title: Text(
                    model.list[index].title,
                  ),
                ),
                onTap: () => {
                  Navigator.of(context)
                      .pushNamed(model.list[index].routeName)
                },
              ),
              childCount: model.list.length,
            ),
          ),
        ],
      ),
    );
  }
}
