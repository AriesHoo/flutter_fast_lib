import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///请求头帮助类-主要告知后台当前登录类型 1-管理员;2-普通用户;3-游客
///普通登录模式
bool get normalLogin => 2 == HeaderHelper.singleton.getLoginType();

///管理员登录模式
bool get adminLogin => 1 == HeaderHelper.singleton.getLoginType();

///游客登录模式
bool get visitorLogin => 3 == HeaderHelper.singleton.getLoginType();

class HeaderHelper {
  static final HeaderHelper _singleton = HeaderHelper._internal();

  static HeaderHelper get singleton => _singleton;

  ///工厂构造函数
  factory HeaderHelper() {
    return _singleton;
  }

  ///构造函数私有化，防止被误创建
  HeaderHelper._internal();

  ///设置当前登录类型--登录入口设置 1-admin 2-normal 3-visitor 4-
  Future<bool> setLoginType(int type) async {
    return await FastSpUtil.putInt('LoginType', type)!;
  }

  ///默认普通用户登录 2
  int getLoginType() {
    int type = FastSpUtil.getInt('LoginType', defValue: 2)!;

    ///默认普通用户
    if (type < 1 || type > 3) {
      type = 2;
    }
    return type;
  }
}

///配置缓存帮助--是否弹出用户协议、是否展示引导页
class SpHelper {
  ///设置是否显示引导页
  static Future<bool> setShowGuidePage(bool show) async {
    return await FastSpUtil.putBool('ShowGuidePage', show)!;
  }

  ///获取是否显示引导页
  static bool? showGuidePage() {
    return FastSpUtil.getBool('ShowGuidePage', defValue: false);
  }

  ///设置是否显示用户协议及隐私条款弹框
  static Future<bool> setShowAgreementDialog(bool show) async {
    return await FastSpUtil.putBool('ShowAgreementDialog', show)!;
  }

  ///获取是否显示用户协议及隐私条款弹框
  static bool? showAgreementDialog() {
    return FastSpUtil.getBool('ShowAgreementDialog', defValue: false);
  }

  ///设置是否可以举报
  static Future<bool> setCanReport(bool enable) async {
    return await FastSpUtil.putBool('canReport', enable)!;
  }

  ///获取是否可举报
  static bool? canReport() {
    return FastSpUtil.getBool('canReport', defValue: false);
  }
}
