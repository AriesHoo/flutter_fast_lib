/// 请求返回baseModel
class BaseResponseModel {
  int? code = 0;
  String? msg;
  dynamic data;
  bool? result;

  BaseResponseModel({this.code, this.msg, this.result, this.data});

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
    result = json['result'];
  }

  @override
  String toString() {
    return 'BaseRespData{code: $code, msg: $msg, result: $result, data: $data}';
  }
}