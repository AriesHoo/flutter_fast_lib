import 'package:flutter_fast_lib/flutter_fast_lib.dart';

double getAdapterSize(double dp) {
  try {
    return dp *
        (isSmallDisplay
            ? 1
            : isDisplayDesktop
                ? 1.2
                : 1.1);
  } catch (e) {
    FastLogUtil.e('e:$e');
  }
  return dp;
}

double getWidth(double dp) {
  return dp;
}

double getHeight(double dp) {
  return dp;
}

double getFontSize(double dp) {
  try {
    return dp *
        (isSmallDisplay
            ? 1
            : isDisplayDesktop
                ? 1.2
                : 1.1);
  } catch (e) {
    FastLogUtil.e('e:$e');
  }
  return dp;
}

///极小间距
double getSpaceMini() {
  return getAdapterSize(6);
}

///小间距
double getSpaceSmall() {
  return getAdapterSize(12);
}

///一般间距
double getSpaceMedium() {
  return getAdapterSize(20);
}
