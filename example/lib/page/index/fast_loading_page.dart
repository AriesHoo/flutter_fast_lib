import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/view_model/index/fast_loading_view_model.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';
import 'package:flutter_fast_lib_example/widget/windmill_indicator.dart';

///[FastLoadingUtil] 示例
class FastLoadingPage extends StatelessWidget {
  const FastLoadingPage({Key? key}) : super(key: key);
  final String info = "FastLoadingUtil提供基于BotToast封装的快速Loading工具。"
      "\n1、指提供showLoading及hideLoading方法"
      "\n2、默认属性及默认实现通过FastLoadingMixin可实现默认属性定制也可通过重写showLoading完全自定义;"
      "\n3、通过FastManager.getInstance().setObserver()进行定制化";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastLoadingUtil示例'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: BasisProviderWidget<FastLoadingViewModel>(
            model: FastLoadingViewModel(),
            builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoCard(info: info),
                SwitchListTile.adaptive(
                  value: model.showText,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) => model.setShowText(value),
                  title: const Text('是否显示文本信息'),
                ),
                SwitchListTile.adaptive(
                  value: model.clickClose,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) => model.setClickClose(value),
                  title: const Text('是否点击背景关闭Loading'),
                ),
                SwitchListTile.adaptive(
                  value: model.allowClick,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) => model.setAllowClick(value),
                  title: const Text('是否可点击背景后Widget'),
                ),
                SwitchListTile.adaptive(
                  value: model.builder,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) => model.setBuilder(value),
                  title: const Text('完全自定义Widget'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FastLoadingUtil.showLoading(
                        allowClick: model.allowClick,
                        clickClose: model.clickClose,
                        duration: model.clickClose
                            ? null
                            : const Duration(milliseconds: 5000),
                        backButtonBehavior: BackButtonBehavior.close,
                        text: model.showText ? 'Loading' : null,
                        onClose: () => FastToastUtil.showSuccess('onClose'),

                        ///完全自定义
                        builder: model.builder
                            ? (_) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(48),
                                  child: const WindmillIndicator(
                                    size: 32.0,
                                    speed: 0.8,
                                  ),
                                )
                            : null);
                  },
                  child: const Text('showLoading'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
