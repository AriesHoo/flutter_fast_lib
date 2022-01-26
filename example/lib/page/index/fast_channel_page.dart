import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';

///[FastMethodChannelUtil] 示例
class FastChannelPage extends StatelessWidget {
  const FastChannelPage({Key? key}) : super(key: key);
  final String info = "FastMethodChannelUtil提供Android系统部分工具操作。"
      "\n1、修改状态栏文字图标颜色"
      "\n2、回到桌面-应用后台";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastMethodChannelUtil示例'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(info: info),
              ElevatedButton(
                onPressed: () => {FastMethodChannelUtil.navigateToSystemHome()},
                child: const Text('navigateToSystemHome-回到桌面'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastMethodChannelUtil
                      .isSupportStatusBarFontChange();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('isSupportStatusBarFontChange\n系统是否支持状态栏文字颜色变化'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result =
                      await FastMethodChannelUtil.setStatusBarLightMode();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('setStatusBarLightMode\n设置亮色模式(黑色文字及图标)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result =
                      await FastMethodChannelUtil.setStatusBarDarkMode();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('setStatusBarDarkMode\n设置暗色模式(白色文字及图标)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastMethodChannelUtil
                      .isSupportNavigationBarFontChange();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('isSupportNavigationBarFontChange\n系统是否支持导航栏文字颜色变化'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result =
                      await FastMethodChannelUtil.setNavigationBarLightMode();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('setNavigationBarLightMode\n设置亮色模式(黑色文字及图标)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result =
                      await FastMethodChannelUtil.setNavigationBarDarkMode();
                  FastToastUtil.show('result:$result');
                },
                child: const Text('setNavigationBarDarkMode\n设置暗色模式(白色文字及图标)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
