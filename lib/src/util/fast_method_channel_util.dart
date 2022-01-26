import 'package:flutter/services.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///MethodChannel 工具类
///2021-09-02 08:21:32-增加非Android平台判断逻辑
class FastMethodChannelUtil {
  static const MethodChannel _channel = MethodChannel('flutter_fast_lib');

  ///Android回到系统桌面
  static void navigateToSystemHome() async {
    if (!FastPlatformUtil.isAndroid) {
      return;
    }
    await _channel.invokeMethod('navigateToSystemHome');
  }

  ///Android是否支持状态栏文字图标颜色变化
  static Future<bool> isSupportStatusBarFontChange() async {
    if (!FastPlatformUtil.isAndroid) {
      return true;
    }
    return await _channel.invokeMethod('isSupportStatusBarFontChange');
  }

  ///Android设置状态栏亮色-黑色图标及文字
  static Future<int> setStatusBarLightMode() async {
    if (!FastPlatformUtil.isAndroid) {
      return -1;
    }
    return await _channel.invokeMethod('setStatusBarLightMode');
  }

  ///Android设置状态栏暗色-白色图标及文字
  static Future<int> setStatusBarDarkMode() async {
    if (!FastPlatformUtil.isAndroid) {
      return -1;
    }
    return await _channel.invokeMethod('setStatusBarDarkMode');
  }

  ///Android是否支持导航栏文字图标颜色变化
  static Future<bool> isSupportNavigationBarFontChange() async {
    if (!FastPlatformUtil.isAndroid) {
      return true;
    }
    return await _channel.invokeMethod('isSupportNavigationBarFontChange');
  }

  ///Android设置导航栏亮色-黑色图标及文字
  static Future<int> setNavigationBarLightMode() async {
    if (!FastPlatformUtil.isAndroid) {
      return -1;
    }
    return await _channel.invokeMethod('setNavigationBarLightMode');
  }

  ///Android设置导航栏暗色-白色图标及文字
  static Future<int> setNavigationBarDarkMode() async {
    if (!FastPlatformUtil.isAndroid) {
      return -1;
    }
    return await _channel.invokeMethod('setNavigationBarDarkMode');
  }
}
