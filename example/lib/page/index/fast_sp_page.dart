import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/main.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';

///[FastSpUtil] 示例
class FastSpPage extends StatelessWidget {
  const FastSpPage({Key? key}) : super(key: key);
  final String info = "FastSpUtil提供基于shared_preferences的sp缓存工具。"
      "\n1、在合适的地方进行初始化initialize-推荐在main方法"
      "\n2、提供基础类型如String、bool、int、double等put(存)、get(取);"
      "\n3、提供model类putObject(存)、getObject(取)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.loadingUtilPage),
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
                  FastToastUtil.show(
                      'isInitialized:${FastSpUtil.initialized()}')
                },
                child: const Text('isInitialized-是否初始化'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result =
                      await FastSpUtil.putString('putString', 'putString');
                  FastToastUtil.show('result:$result');
                },
                child: const Text('putString'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = FastSpUtil.getString('putString');
                  FastToastUtil.show('string:$result');
                },
                child: const Text('getString'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastSpUtil.clear();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('clear'),
              ),
              ElevatedButton(
                onPressed: () async {
                  FastToastUtil.show('isProduction:$isProduction');
                },
                child: const Text('isProduction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
