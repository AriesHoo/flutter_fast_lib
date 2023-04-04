import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

export 'dart:io';

/// 是否是生产环境
const bool isProduction = bool.fromEnvironment("dart.vm.product");

///Platform简易工具-什么系统
///应用版本信息-应用名、版本名、版本号、包名等
///Android iOS设备相关信息-是否物理设备、品牌、型号、系统版本、Android支持cpu
///1、2021-12-02 09:32 修改成device_info_plus插件并修改部分方法
///2、2021-12-02 09:40 修改成package_info_plus插件增加[getBuildSignature]方法修改[getAppVersion]为[getVersion]
class FastPlatformUtil {
  ///操作系统
  static String get operatingSystem => isWeb ? 'web' : Platform.operatingSystem;

  ///判断当前是否为web系统
  static bool get isWeb => kIsWeb;

  ///是否Linux系统
  static bool get isLinux => !isWeb && Platform.isLinux;

  ///是否Mac系统
  static bool get isMacOS => !isWeb && Platform.isMacOS;

  ///是否Windows系统
  static bool get isWindows => !isWeb && Platform.isWindows;

  ///是否Android系统
  static bool get isAndroid => !isWeb && Platform.isAndroid;

  ///是否iOS系统
  static bool get isIOS => !isWeb && Platform.isIOS;

  ///是否Fuchsia系统
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;

  ///是否手机系统
  static bool get isMobile => isAndroid || isIOS;

  ///是否桌面系统
  static bool get isDesktop => isLinux || isMacOS || isWindows;

  ///获取应用名
  static Future<String> getAppName() async {
    return await PackageInfo.fromPlatform().then((value) => value.appName);
  }

  ///获取应用包名-Android packageName iOS bundleIdentifier
  static Future<String> getPackageName() async {
    return await PackageInfo.fromPlatform().then((value) => value.packageName);
  }

  ///获取应用版本--如1.0.0
  static Future<String> getVersion() async {
    return await PackageInfo.fromPlatform().then((value) => value.version);
  }

  ///获取应用构建次数--如100
  static Future<String> getBuildNumber() async {
    return await PackageInfo.fromPlatform().then((value) => value.buildNumber);
  }

  ///获取应用构建签名
  static Future<String> getBuildSignature() async {
    return await PackageInfo.fromPlatform()
        .then((value) => value.buildSignature);
  }

  ///获取系统相关信息
  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      return await deviceInfo.androidInfo;
    } else if (isIOS) {
      return await deviceInfo.iosInfo;
    } else if (isWeb) {
      return await deviceInfo.webBrowserInfo;
    } else if (isMacOS) {
      return await deviceInfo.macOsInfo;
    } else if (isWindows) {
      return await deviceInfo.windowsInfo;
    } else if (isLinux) {
      return deviceInfo.linuxInfo;
    } else {
      return null;
    }
  }

  ///是否物理设备-排查模拟器
  static Future<bool> isPhysicalDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return await deviceInfo.androidInfo
          .then((value) => true == value.isPhysicalDevice);
    } else if (Platform.isIOS) {
      return await deviceInfo.iosInfo
          .then((value) => true == value.isPhysicalDevice);
    } else {
      return false;
    }
  }

  ///获取设备品牌
  static Future<String> getBrand() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return await deviceInfo.androidInfo.then((value) => '${value.brand}');
    } else if (Platform.isIOS) {
      ///iPhone/iPad
      return await deviceInfo.iosInfo
          .then((value) => value.localizedModel ?? '');
    } else if (Platform.isWindows) {
      return await deviceInfo.windowsInfo.then((value) => value.computerName);
    } else if (Platform.isLinux) {
      return await deviceInfo.linuxInfo.then((value) => value.name);
    } else {
      return '';
    }
  }

  ///获取设备型号-获取model
  static Future<String> getModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      return await deviceInfo.androidInfo.then((value) => '${value.model}');
    } else if (isIOS) {
      return await deviceInfo.iosInfo
          .then((value) => value.utsname.machine ?? '');
    } else if (isMacOS) {
      return await deviceInfo.macOsInfo.then((value) => value.model);
    } else if (isWindows) {
      return await deviceInfo.windowsInfo
          .then((value) => value.numberOfCores.toString());
    } else {
      return '';
    }
  }

  ///获取系统版本
  static Future<String> getSystemVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      return await deviceInfo.androidInfo
          .then((value) =>  '${value.version.release}');
    } else if (isIOS) {
      return await deviceInfo.iosInfo
          .then((value) => value.systemVersion ?? '');
    } else {
      return '';
    }
  }

  ///获取手机型号-获取Android手机支持的cpuAbi
  static Future<List<String?>> getSupportedAbi() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      return await deviceInfo.androidInfo.then((value) => value.supportedAbis);
    } else {
      return [];
    }
  }

  ///系统状态栏颜色是否可修改
  static Future<bool> statusColorCanChange() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      return info.version.sdkInt! >= 23;
    } else {
      return true;
    }
  }

  ///系统导航栏颜色是否可修改
  static Future<bool> navigationColorCanChange() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      return info.version.sdkInt! >= 26;
    } else {
      return true;
    }
  }
}
