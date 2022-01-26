import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:logger/logger.dart';

///[FastLogUtil]默认配置参数及最终实现--方便自定义
mixin FastLogMixin {
  ///debug模式下才打印日志
  ///默认非开发环境开启debug模式
  bool get debug => !isProduction;

  ///日志tag
  String get tag => 'FastLogUtil';

  ///开始堆栈跟踪的索引[PrettyPrinter]
  ///例如，如果记录器包装在另一个类中，并且
  ///您希望从堆栈跟踪中删除这些包装调用
  int get stackTraceBeginIndex => 0;

  ///跟踪方法数
  int get methodCount => 2;

  ///错误跟踪方法数
  int get errorMethodCount => 8;

  ///tag长度
  int get lineLength => 120;

  ///是否各种颜色类型--
  ///colors not support see https://github.com/leisim/logger/issues/2
  bool get colors => false;

  ///打印表情符号😊
  bool get printEmojis => true;

  ///打印日期
  bool get printTime => true;

  ///[Logger]对象可完全自定义--为空则根据[stackTraceBeginIndex]至[printTime]生成默认
  Logger? get logger => null;
}
