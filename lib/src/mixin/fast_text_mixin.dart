import 'package:flutter_fast_lib/src/widget/state/fast_empty_state_widget.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_error_state_widget.dart';

///默认文本
///[FastRefreshObserver]
///[LoadStatus]
mixin FastTextMixin {
  ///[FastEmptyStateWidget]
  String get stateEmptyMessage => '暂无数据';

  ///[FastEmptyStateWidget]
  String get stateRetryText => '点击重试';

  ///[FastErrorStateWidget]
  String get stateErrorMessage => '好像出了什么问题';
}
