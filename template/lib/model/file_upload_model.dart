
import 'package:flutter_fast_lib_template/util/app_util.dart';

///文件上传七牛后返回参数对象
class QiNiuBackModel {
  String? bucket;
  int? fsize;
  String? hash;
  String? key;

  QiNiuBackModel({bucket, fsize, hash, key});

  factory QiNiuBackModel.fromJson(Map<String, dynamic> json) {
    return QiNiuBackModel(
      bucket: json['bucket'],
      fsize: parseInt(json['fsize']),
      hash: json['hash'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bucket'] = bucket;
    data['fsize'] = fsize;
    data['hash'] = hash;
    data['key'] = key;
    return data;
  }
}

///上传七牛云成功后再次将信息提交自己后台参数
class FileUploadModel {
  String? fileType;
  String? hash;
  int? length;
  String? mediaType;
  String? name;
  String? qiniuKey;
  String? size;
  int? type;
  String? url;

  FileUploadModel(
      {fileType,
      hash,
      length,
      mediaType,
      name,
      qiniuKey,
      size,
      type,
      url});

  factory FileUploadModel.fromJson(Map<String, dynamic> json) {
    return FileUploadModel(
      fileType: json['fileType'],
      hash: json['hash'],
      length: parseInt(json['length']),
      mediaType: json['mediaType'],
      name: json['name'],
      qiniuKey: json['qiniuKey'],
      size: json['size'],
      type: parseInt(json['type']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileType'] = fileType;
    data['hash'] = hash;
    data['length'] = length;
    data['mediaType'] = mediaType;
    data['name'] = name;
    data['qiniuKey'] = qiniuKey;
    data['size'] = size;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
