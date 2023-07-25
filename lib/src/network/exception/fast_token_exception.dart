/// 登录token异常
class FastTokenException implements Exception {
  ///错误信息
  String? message;
  int? code;

  FastTokenException({this.message, this.code});

  @override
  String toString() {
    return 'FastTokenException{message: $message,code:$code}';
  }
}
