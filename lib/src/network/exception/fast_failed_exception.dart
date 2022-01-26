/// 接口返回明确错误异常
class FastFailedException implements Exception {
  String? message;
  int? code;

  FastFailedException({this.message, this.code});

  @override
  String toString() {
    return 'FastFailedException{message: $message,code:$code}';
  }
}
