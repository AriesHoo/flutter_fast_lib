import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';

///[FastDialog] 示例
class FastDialogPage extends StatelessWidget {
  const FastDialogPage({Key? key}) : super(key: key);
  final String info = "FastDialog提供基于Dialog魔改的快速Dialog组件。"
      "\n1、扩展minWidth、maxWidth、alignment等属性;"
      "\n2、默认属性及默认实现通过FastDialogMixin可实现默认属性定制;"
      "\n3、通过FastManager.getInstance().setObserver()进行定制化";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastDialog示例'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(info: info),
              ElevatedButton(
                onPressed: () => {
                  showDialog(
                    context: context,
                    // barrierColor: Colors.blue,
                    useSafeArea: false,
                    builder: (context) => FastDialog(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 400,
                            width: double.infinity,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  )
                },
                child: const Text('showDialog'),
              ),
              ElevatedButton(
                onPressed: () => {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const FastDialog(
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                      ),
                      maxWidth: double.infinity,
                      alignment: Alignment.bottomCenter,
                      // insetPadding: EdgeInsets.zero,
                    ),
                  )
                },
                child: const Text('showModalBottomSheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
