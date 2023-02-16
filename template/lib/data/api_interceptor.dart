import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/helper/app_helper.dart';
import 'package:flutter_fast_lib_template/helper/user_helper.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/mixin/fast_lib_mixin.dart';
import 'package:flutter_fast_lib_template/model/base_list_model.dart';
import 'package:flutter_fast_lib_template/model/base_response_model.dart';
import 'package:flutter_fast_lib_template/model/file_upload_model.dart';

///拦截器--添加统一header及统一数据返回处理
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    ///此处设置header要先获取默认header再进行添加
    ///否则post/put传递body会出现问题;get等之前传query 参数的不会出现
    ///切记
    Map<String, dynamic> headers = options.headers;
    headers.putIfAbsent(
        'platform',
        () => FastPlatformUtil.isWeb
            ? 'pc'
            : FastPlatformUtil.operatingSystem.toLowerCase());
    headers.putIfAbsent('User-Agent', () => 'Mozilla/5.0 (Android)');
    if (UserHelper.isLogin) {
      ///token
      headers.putIfAbsent('X-Token', () => UserHelper.token);
      var versionCode = await FastPlatformUtil.getBuildNumber();
      var versionName = await FastPlatformUtil.getVersion();

      ///App版本
      headers.putIfAbsent('versionCode', () => versionCode);
      headers.putIfAbsent('versionName', () => versionName);
    }

    ///设置当前登录类型-1-管理员;2-普通用户;3-游客
    headers.putIfAbsent(
        'ADMIN_ENTER', () => HeaderHelper.singleton.getLoginType());
    options.headers = headers;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printKV('*** Response ***', '');
    _printResponse(response);

    ///关闭所有toast
    clearToast();

    ///文件上传七牛云功能
    if (response.requestOptions.uri
        .toString()
        .contains(AppConstant.fileUploadPath)) {
      response.data = QiNiuBackModel.fromJson(response.data);
      handler.resolve(response);
      return;
    }

    ///app内接口
    BaseResponseModel respData;
    if (response.data is Map) {
      respData = BaseResponseModel.fromJson(response.data);
    } else {
      super.onResponse(response, handler);
      return;
    }
    // FastLogUtil.e('respData0:${respData.data};result:${respData.result}', tag: 'httpHandlerTag');
    if (true == respData.result) {
      response.data = respData.data ?? true;
      // FastLogUtil.e('respData1:${respData.data}', tag: 'httpHandlerTag');
      BaseListModel listModel;
      try {
        listModel = BaseListModel.fromJson(response.data);
        response.data = listModel.list ?? response.data;
        FastLogUtil.v(
            'BaseListModel:$listModel;isMap:${listModel.list is Map}');
      } catch (e) {
        FastLogUtil.e('e:$e');
      }
      response.data = response.data ?? true;
      // FastLogUtil.e('respData2:${response.data}', tag: 'httpHandlerTag');
      return handler.resolve(response);
    } else {
      /// 505 在其它设备登录
      /// 506 token过期
      /// 509 异常-如账号被删除-提示账号信息不存在
      if (respData.code == 505 ||
          respData.code == 506 ||
          respData.code == 509) {
        throw FastTokenException(
          message: appString.tokenErrorMessage,
          code: respData.code,
        );
      }
      throw FastFailedException(
        message: respData.msg,
        code: respData.code,
      );
    }
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    FastLogUtil.v(
        'api-interceptor-onError-path${err.requestOptions.path};errorType:${err.type};err:$err');

    ///异常错误-token过期弹框提示重新登录
    if (err.error is FastTokenException) {
      ///token过期直接清空用户信息及权限列表
      UserHelper.clearUserInfo();
      _showTokenDialog(err.error.code);
    }
    super.onError(err, handler);
  }

  ///挤下线弹框
  // LoginDialogHelper? _dialogHelper;

  ///token过期弹框
  _showTokenDialog(int? code) {
    // if (_dialogHelper != null) {
    //   _dialogHelper!.dismiss();
    // }
    // _dialogHelper =
    //     LoginDialogHelper().setMessage('${appString.tokenErrorMessage}($code)');
    // _dialogHelper!.show(barrierDismissible: false);
  }

  ///打印返回数据日志
  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    _printKV('statusCode', response.statusCode);
    if (response.isRedirect == true) {
      _printKV('redirect', response.realUri);
    }

    _printKV('headers:', '');
    response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    _printKV('Response Text', response.toString());
  }

  ///打印日志
  _printKV(String key, dynamic value) {
    bool json = value != null && value.toString().contains('Instance');
    if (!fastLibMixin.debug) {
      return;
    }
    try {
      print.call(
          '${fastLibMixin.tag}ApiInterceptor_$key: ${json ? JsonUtil.encodeObj(value) : value}');
    } catch (e) {
      print.call('${fastLibMixin.tag}ApiInterceptor_$key: $value');
    }
  }
}
