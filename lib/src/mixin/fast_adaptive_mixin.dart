import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///获取屏幕尺寸类型
AdaptiveWindowType get windowType => getWindowType(currentContext);

///大屏幕-宽度大于1024-
bool get isDisplayDesktop =>
    FastManager.getInstance().adaptiveMixin.isDisplayDesktop;

///中屏幕-宽度600-1023
bool get isDisplaySmallDesktop =>
    FastManager.getInstance().adaptiveMixin.isDisplaySmallDesktop;

///小屏幕--按手机处理宽度小于600
bool get isSmallDisplay =>
    FastManager.getInstance().adaptiveMixin.isSmallDisplay;

///屏幕响应式尺寸
mixin FastAdaptiveMixin {
  ///大屏幕-宽度大于1024-
  bool get isDisplayDesktop => FastPlatformUtil.isMobile
      ? windowType >= AdaptiveWindowType.medium
      : windowType > AdaptiveWindowType.medium;

  ///中屏幕-宽度600-1023
  bool get isDisplaySmallDesktop => FastPlatformUtil.isMobile
      ? windowType == AdaptiveWindowType.medium
      : windowType == AdaptiveWindowType.small;

  ///小屏幕--按手机处理宽度小于600
  bool get isSmallDisplay => windowType == AdaptiveWindowType.xsmall;
}
