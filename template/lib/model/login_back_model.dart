import 'package:flutter_fast_lib_template/util/app_util.dart';

///登录成功后返回数据model
class LoginBackModel {
  String? accessToken;
  int? accountId;
  int? userId;
  String? accountName;
  String? accountPhoto;
  String? institutionName;
  String? jobNumber;
  bool? passwordCheck;
  String? phone;

  ///角色类型 1-管理员 2-老师 3-学生家长
  ///4-游客 5-师培空间栏目管理员 6-师培空间 特邀用户
  ///7-帮扶专区用户 8-帮扶专区专区管理员
  List<RoleSet>? roleSet;
  String? sex;
  String? sy;
  bool? isViewByOthers;

  LoginBackModel({
    this.accessToken,
    this.accountId,
    this.userId,
    this.accountName,
    this.accountPhoto,
    this.institutionName,
    this.jobNumber,
    this.passwordCheck,
    this.phone,
    this.roleSet,
    this.sex,
    this.sy,
    this.isViewByOthers,
  });

  factory LoginBackModel.fromJson(Map<String?, dynamic> json) {
    return LoginBackModel(
      accessToken: json['accessToken'],
      accountId: parseInt(json['accountId']),
      userId: parseInt(json['userId']),
      accountName: json['accountName'],
      accountPhoto: json['accountPhoto'],
      institutionName: json['institutionName'],
      jobNumber: json['jobNumber'],
      passwordCheck: json['passwordCheck'],
      phone: json['phone'],
      roleSet: json['roleSet'] != null
          ? (json['roleSet'] as List).map((i) => RoleSet.fromJson(i)).toList()
          : null,
      sex: json['sex'],
      sy: json['sy'],
      isViewByOthers: json['isViewByOthers'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['accountId'] = accountId;
    data['userId'] = userId;
    data['accountName'] = accountName;
    data['accountPhoto'] = accountPhoto;
    data['institutionName'] = institutionName;
    data['jobNumber'] = jobNumber;
    data['passwordCheck'] = passwordCheck;
    data['phone'] = phone;
    data['sex'] = sex;
    data['sy'] = sy;
    data['isViewByOthers'] = isViewByOthers;
    if (roleSet != null) {
      data['roleSet'] = roleSet!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<int?> getRoleType() {
    List<int?> listRole = [];
    if (roleSet != null) {
      for (var element in roleSet!) {
        listRole.add(element.roleType);
      }
    }
    return listRole;
  }
}

class RoleSet {
  int? id;
  bool? isDelete;
  bool? isFailure;
  int? isPc;
  String? name;
  int? roleType;

  RoleSet(
      {this.id,
      this.isDelete,
      this.isFailure,
      this.isPc,
      this.name,
      this.roleType});

  factory RoleSet.fromJson(Map<String, dynamic> json) {
    return RoleSet(
      id: parseInt(json['id']),
      isDelete: json['isDelete'],
      isFailure: json['isFailure'],
      isPc: json['isPc'],
      name: json['name'],
      roleType: json['roleType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isDelete'] = isDelete;
    data['isFailure'] = isFailure;
    data['isPc'] = isPc;
    data['name'] = name;
    data['roleType'] = roleType;
    return data;
  }
}
