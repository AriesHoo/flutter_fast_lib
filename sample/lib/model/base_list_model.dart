
import 'package:flutter_blood_belfry/util/app_util.dart';

/// 请求返回data为 {"total":1,"list":[]}格式的
class BaseListModel {
  int? total = 0;
  dynamic list;

  BaseListModel({this.total, this.list});

  BaseListModel.fromJson(Map<String, dynamic> json) {
    total = parseInt(json['total']);
    list = json['list'];
  }

  @override
  String toString() {
    return 'BaseListModel{total: $total list: $list}';
  }
}