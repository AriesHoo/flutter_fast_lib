import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///[BasisViewModel]错误分类
class BasisViewStateError {
  BasisErrorType errorType;
  String? message;
  dynamic error;

  BasisViewStateError(this.errorType, {this.message, this.error});

  ///网络错误
  bool get networkError => errorType == BasisErrorType.network;

  ///错误信息
  String get errorMessage => message ?? '';

  @override
  String toString() {
    return 'BasisViewStateError{errorType: $errorType, message: $message, error: $error}';
  }
}
