import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';

/// [FastLogInterceptor] is used to print logs during network requests.
/// It's better to add [FastLogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
/// [FastNetwork]
/// [LogInterceptor]
class FastLogInterceptor extends Interceptor {
  FastLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint,
    this.tag = 'FastLogInterceptor',
    this.debug = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// tag
  String? tag;

  ///log模式
  bool debug;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(beforePrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object)? logPrint;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    beforePrint('*** onRequestStart ***');
    _printKV('uri', options.uri);
    //options.headers;

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType);
      _printKV('contentType', options.contentType);
      _printKV('followRedirects', options.followRedirects);
      _printKV('connectTimeout', options.connectTimeout);
      _printKV('sendTimeout', options.sendTimeout);
      _printKV('receiveTimeout', options.receiveTimeout);
      _printKV(
          'receiveDataWhenStatusError', options.receiveDataWhenStatusError);
      _printKV('extra', options.extra);
    }
    if (requestHeader) {
      if (ObjectUtil.isNotEmpty(options.headers)) {
        beforePrint('headers:');
        options.headers.forEach((key, v) => _printKV(' $key', v));
      }
    }
    if (requestBody) {
      if (ObjectUtil.isNotEmpty(options.data)) {
        _printKV('data', options.data);
      }
      if (ObjectUtil.isNotEmpty(options.queryParameters)) {
        beforePrint('queryParameters:');
        options.queryParameters.forEach((key, v) => _printKV(' $key', v));
      }
    }
    beforePrint('*** onRequestEnd ***');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    beforePrint('*** onResponseStart ***');
    _printResponse(response);
    beforePrint('*** onResponseEnd ***');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (error) {
      beforePrint('*** DioErrorStart***');
      beforePrint('uri: ${err.requestOptions.uri}');
      beforePrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      beforePrint('*** DioErrorEnd ***');
    }

    handler.next(err);
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }
      if (ObjectUtil.isNotEmpty(response.headers)) {
        beforePrint('headers:');
        response.headers
            .forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
      }
    }
    if (responseBody) {
      beforePrint('Response Text:');
      _printAll(response.toString());
    }
    beforePrint('');
  }

  void _printKV(String key, Object? value) {
    bool json = value != null && value.toString().contains('Instance');
    try {
      beforePrint('$key: ${json ? JsonUtil.encodeObj(value) : value}');
    } catch (e) {
      beforePrint('$key: $value');
    }
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(beforePrint);
  }

  ///打印前添加统一tag
  beforePrint(Object object) {
    if (!debug) return;
    if (logPrint != null) {
      logPrint!('${ObjectUtil.isNotEmpty(tag) ? '$tag | ' : ''}$object');
    } else {
      print.call('${ObjectUtil.isNotEmpty(tag) ? '$tag | ' : ''}$object');
    }
  }
}
