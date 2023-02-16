import 'package:flutter_blood_belfry/model/login_back_model.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///用户相关帮助类
class UserHelper {
  ///设置上次登录账号当前为手机号
  static Future<bool> setLastLoginAccount(String account) async {
    return await FastSpUtil.putString('LastLoginAccount', account)!;
  }

  ///获取上次登录账号当前为手机号
  static String get lastLoginAccount =>
      FastSpUtil.getString('LastLoginAccount') ?? '';

  static Future<bool> setLoginBackModel(LoginBackModel model) async {
    return await FastSpUtil.putObject('LoginBackModel', model)!;
  }

  static LoginBackModel? get loginBackModel {
    Map? back = FastSpUtil.getObject('LoginBackModel');
    if (back != null) {
      return LoginBackModel.fromJson(back as Map<String?, dynamic>);
    }
    return null;
  }

  static bool get isLogin => !TextUtil.isEmpty(token);

  static String get token => loginBackModel?.accessToken ?? '';

  static Future<bool> setImageUrl(String? url) {
    LoginBackModel model = loginBackModel!;
    model.accountPhoto = url ?? '';
    return setLoginBackModel(model);
  }

  static String get imageUrl => loginBackModel?.accountPhoto ?? '';

  static Future<bool> setSearchByOthers(bool enable) {
    LoginBackModel model = loginBackModel!;
    model.isViewByOthers = enable;
    return setLoginBackModel(model);
  }

  static bool get searchByOthers => loginBackModel?.isViewByOthers ?? false;

  static int get userId => loginBackModel?.userId ?? -1;

  static String get userPhone => loginBackModel?.phone ?? '';

  static String get accountName => loginBackModel?.accountName ?? '';

  ///是否女性
  static bool get female => (loginBackModel?.sex ?? '').contains('女');

  ///是否女性
  static String get sex => loginBackModel?.sex ?? '男';

  static String get jobNumber => loginBackModel?.jobNumber ?? '';

  static String get institutionName => loginBackModel?.institutionName ?? '';

  ///管理员-type 1
  static bool get admin => (loginBackModel?.getRoleType() ?? []).contains(1);

  ///老师 -type 2
  static bool get teacher => (loginBackModel?.getRoleType() ?? []).contains(2);

  static bool get teacherAdmin => admin || teacher;

  ///学生家长 -type 3
  static bool get studentParent =>
      (loginBackModel?.getRoleType() ?? []).contains(3);

  ///是否密码已校验
  static bool get passwordCheck => loginBackModel?.passwordCheck ?? true;

  ///清空用户信息-token过期、退出登录
  static clearUserInfo() {
    UserHelper.setLoginBackModel(LoginBackModel());
  }
}
