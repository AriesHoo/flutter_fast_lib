import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';

/// 下载App
class DownloadAppViewModel extends BasisViewModel {
  ///检查运行环境
  void checkRunPlatform() async {
    bool _runOnMobile = FastPlatformUtil.isMobile;
    if (!_runOnMobile && FastPlatformUtil.isWeb) {
      webBrowserInfo = await FastPlatformUtil.getDeviceInfo();

      FastLogUtil.e('userAgent:${webBrowserInfo?.userAgent}',tag: 'webBrowserInfoTag');
      _runOnMobile = runOnMobile;
    }
    if (_runOnMobile) {
      openUrl(AppConstant.downloadApkUrl);
    }
  }
}
