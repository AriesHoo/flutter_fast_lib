import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/view_model/index/fast_toast_view_model.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';

///[FastToastUtil]示例
class FastToastPage extends StatelessWidget {
  const FastToastPage({Key? key}) : super(key: key);

  final String info = "FastToastUtil提供基于BotToast封装的快速Toast工具。"
      "\n1、默认属性及默认实现通过FastToastMixin可实现默认属性定制;"
      "\n2、通过FastManager.getInstance().setObserver()进行定制化";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastToastUtil示例'),
      ),
      body: SingleChildScrollView(
        child: BasisProviderWidget<FastToastViewModel>(
          model: FastToastViewModel(),
          builder: (context, model, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(info: info),
              SwitchListTile.adaptive(
                title: const Text('是否Notification模式'),
                value: model.notification,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) => model.setNotification(value),
              ),
              ElevatedButton(
                onPressed: () => FastToastUtil.show(
                  'showToast',
                  notification: model.notification,
                ),
                child: const Text('showToast'),
              ),
              ElevatedButton(
                onPressed: () => FastToastUtil.showSuccess(
                  'showSuccessToast',
                  notification: model.notification,
                ),
                child: const Text('showSuccessToast'),
              ),
              ElevatedButton(
                onPressed: () => FastToastUtil.showWarning(
                  'showWarningToast',
                  notification: model.notification,
                ),
                child: const Text('showWarningToast'),
              ),
              ElevatedButton(
                onPressed: () => FastToastUtil.showError(
                  'showErrorToast',
                  notification: model.notification,
                ),
                child: const Text('showErrorToast'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
