import 'dart:collection';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/network/fast_log_interceptor.dart';

///网络请求封装全局唯一dio对象
///1、2021-12-02 10:37 修改[init]为[_initialize]初始化使用[FastNetworkMixin]
///2、2021-12-03 15:37 修改[FastLogInterceptor]初始化位置避免参数打印不全
class FastNetwork {
  static FastNetwork? _instance;

  ///全局唯一dio
  static Dio? _dio;

  factory FastNetwork.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    if (_instance == null) {
      _instance = FastNetwork._internal();

      ///初始化
      _dio = Dio();
    }
    return _instance;
  }

  ///构造函数私有化，防止被误创建
  FastNetwork._internal();

  ///获取全局唯一dio对象
  Dio get dio => _dio!;

  ///是否初始化
  static bool _initialized = false;

  ///初始化
  FastNetwork _initialize({
    required String baseUrl,
    ResponseType responseType = ResponseType.json,
    String? contentType,
    Map<String, dynamic>? headers,
    int? connectTimeout,
    int? receiveTimeout,
    int? sendTimeout,
    FastLogInterceptor? logInterceptor,
    Interceptor? interceptor,
    Iterable<Interceptor>? interceptors,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.responseType = responseType;
    dio.options.contentType = contentType;
    dio.options.connectTimeout = connectTimeout ?? 30 * 100;
    dio.options.receiveTimeout = receiveTimeout ?? 30 * 100;
    dio.options.sendTimeout = sendTimeout ?? 30 * 100;

    ///添加单个拦截器
    if (interceptor != null) {
      dio.interceptors.add(interceptor);
    }

    ///添加多个拦截器
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }

    ///添加日志拦截器-放在所有拦截器最后
    if (logInterceptor != null) {
      dio.interceptors.add(logInterceptor);
    }

    ///增加全局header
    if (headers != null) {
      Map<String, dynamic> mapHeaders = dio.options.headers;
      mapHeaders.addAll(headers);
      dio.options.headers = mapHeaders;
    }
    return _getInstance();
  }

  ///初始化
  _init() {
    if (_initialized) {
      return;
    }
    _initialize(
      baseUrl: FastManager.getInstance().networkMixin.baseUrl,
      headers: FastManager.getInstance().networkMixin.headers,
      responseType: FastManager.getInstance().networkMixin.responseType,
      contentType: FastManager.getInstance().networkMixin.contentType,
      connectTimeout: FastManager.getInstance().networkMixin.connectTimeout,
      receiveTimeout: FastManager.getInstance().networkMixin.receiveTimeout,
      sendTimeout: FastManager.getInstance().networkMixin.sendTimeout,
      logInterceptor: FastManager.getInstance().networkMixin.logInterceptor,
      interceptor: FastManager.getInstance().networkMixin.interceptor,
      interceptors: FastManager.getInstance().networkMixin.interceptors,
    );
    _initialized = true;
  }

  ///增加全局header
  FastNetwork addHeader(String key, dynamic value) {
    Map<String, dynamic>? headers = HashMap();
    headers.putIfAbsent(key, () => value);
    return addHeaders(headers: headers);
  }

  ///增加全局header
  FastNetwork addHeaders({
    Map<String, dynamic>? headers,
  }) {
    ///增加全局header
    if (headers != null) {
      Map<String, dynamic> mapHeaders = dio.options.headers;
      mapHeaders.addAll(headers);
      dio.options.headers = mapHeaders;
    }
    return _getInstance();
  }

  ///loading开始
  _doStart({
    CancelToken? cancelToken,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
  }) {
    dynamic fun;
    if (showLoading) {
      fun = doLoadingStart != null
          ? doLoadingStart()
          : FastManager.getInstance().networkMixin.doLoadingStart(
                canceledOnTouchOutside: canceledOnTouchOutside,
                loading: loading,
                messageStyle: loadingMessageStyle,
                messageText: loadingMessageText,
                cancelToken: cancelToken,
              );
    }
    return fun;
  }

  ///loading 结束
  _doFinish({
    bool showLoading = false,
    dynamic fun,
    Function({dynamic func})? doLoadingFinish,
  }) {
    if (showLoading) {
      if (doLoadingFinish != null) {
        doLoadingFinish(func: fun);
      } else {
        FastManager.getInstance().networkMixin.doLoadingFinish(func: fun);
      }
    }
  }

  ///发起get请求
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起post请求
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起put请求
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起head请求
  Future<Response<T>> head<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.head(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起delete请求
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起path请求
  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起download请求
  Future<Response> download(
    String urlPath,
    savePath, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response response = await dio.download(
        urlPath,
        savePath,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        deleteOnError: true,
        lengthHeader: lengthHeader,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }

  ///发起request请求
  Future<Response<T>> request<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showLoading = false,
    bool canceledOnTouchOutside = true,
    Widget? loading,
    TextStyle? loadingMessageStyle,
    String? loadingMessageText,
    dynamic Function()? doLoadingStart,
    Function({dynamic func})? doLoadingFinish,
  }) async {
    _init();

    ///显示loading
    dynamic fun = _doStart(
      cancelToken: cancelToken,
      showLoading: showLoading,
      canceledOnTouchOutside: canceledOnTouchOutside,
      loading: loading,
      loadingMessageStyle: loadingMessageStyle,
      loadingMessageText: loadingMessageText,
      doLoadingStart: doLoadingStart,
    );

    try {
      Response<T> response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    } finally {
      _doFinish(
        showLoading: showLoading,
        fun: fun,
      );
    }
  }
}
