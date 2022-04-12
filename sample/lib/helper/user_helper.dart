import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_blood_belfry/model/login_back_model.dart';

///用户相关帮助类
class UserHelper {
  ///设置上次登录账号当前为手机号
  static Future<bool> setLastLoginAccount(String account) async {
    return await FastSpUtil.putString('LastLoginAccount', account)!;
  }

  ///获取上次登录账号当前为手机号
  static String? getLastLoginAccount() {
    return FastSpUtil.getString('LastLoginAccount');
  }

  static Future<bool> setLoginBackModel(LoginBackModel model) async {
    return await FastSpUtil.putObject('LoginBackModel', model)!;
  }

  static LoginBackModel? getLoginBackModel() {
    Map? back = FastSpUtil.getObject('LoginBackModel');
    if (back != null) {
      return LoginBackModel.fromJson(back as Map<String?, dynamic>);
    }
    return null;
  }

  static bool isLogin() {
    return !TextUtil.isEmpty(getToken());
  }

  static String getToken() {
    LoginBackModel? model = getLoginBackModel();
    return model?.accessToken ?? '';
  }

  static Future<bool> setImageUrl(String? url) {
    LoginBackModel model = getLoginBackModel()!;
    model.accountPhoto = url;
    return setLoginBackModel(model);
  }

  static String getImageUrl() {
    LoginBackModel? model = getLoginBackModel();
    return model?.accountPhoto ?? '';
  }

  static Future<bool> setSearchByOthers(bool enable) {
    LoginBackModel model = getLoginBackModel()!;
    model.isViewByOthers = enable;
    return setLoginBackModel(model);
  }

  static bool getSearchByOthers() {
    LoginBackModel? model = getLoginBackModel();
    return model?.isViewByOthers ?? false;
  }

  static int getUserId() {
    LoginBackModel? model = getLoginBackModel();
    return model?.userId ?? -1;
  }

  static String getUserPhone() {
    LoginBackModel? model = getLoginBackModel();
    return model?.phone ?? '';
  }

  static String getAccountName() {
    LoginBackModel? model = getLoginBackModel();
    return model?.accountName ?? '';
  }

  ///是否女性
  static bool isFemale() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.sex ?? '').contains('女');
  }

  static String getJobNumber() {
    LoginBackModel? model = getLoginBackModel();
    return model?.jobNumber ?? '';
  }

  static String getInstitutionName() {
    LoginBackModel? model = getLoginBackModel();
    return model?.institutionName ?? '';
  }

  static String getPhoneNumber() {
    LoginBackModel? model = getLoginBackModel();
    return model?.phone ?? '';
  }

  ///管理员-type 1
  static bool isAdmin() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(1);
  }

  ///老师 -type 2
  static bool isTeacher() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(2);
  }

  static bool isTeacherOrAdmin() {
    return isAdmin() || isTeacher();
  }

  ///学生家长 -type 3
  static bool isStudentParent() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(3);
  }

  ///游客 -type 4
  static bool isVisitor() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(4);
  }

  ///师培空间-前端管理员 -type 5
  static bool isTeacherTrainingManager() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(5);
  }

  ///师培空间-特邀用户 -type 6
  static bool isTeacherTrainingSpecial() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(6);
  }

  ///帮扶专区用户 -type 7
  static bool isHelperZoneUser() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(7);
  }

  ///帮扶专区 专区管理员(前端) -type 8
  static bool isHelperZoneManager() {
    LoginBackModel? model = getLoginBackModel();
    return (model?.getRoleType() ?? []).contains(8);
  }

  ///是否密码已校验
  static bool passwordCheck() {
    LoginBackModel? model = getLoginBackModel();
    // return true;
    return model?.passwordCheck ?? true;
  }

  ///清空用户信息-token过期、退出登录
  static clearUserInfo() {
    UserHelper.setLoginBackModel(LoginBackModel());
    ///RolePermissionHelper.setListPermission([]);
  }
}
