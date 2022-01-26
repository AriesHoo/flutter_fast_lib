import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/manager/route_manager.dart';
import 'package:flutter_fast_lib_template/theme/app_theme_data.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';
import 'package:flutter_fast_lib_template/util/auto_size_util.dart';
import 'package:flutter_fast_lib_template/view_model/download_app_view_model.dart';
import 'package:flutter_fast_lib_template/widget/button.dart';
import 'package:flutter_fast_lib_template/widget/image_loader.dart';
import 'package:flutter_fast_lib_template/widget/logo_header.dart';

///下载app页面
class DownloadAppPage extends StatelessWidget {
  const DownloadAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FastLogUtil.e(
        'DownloadAppPageWidth:${MediaQuery.of(context).size.width};isSmallDisplay:$isSmallDisplay}');

    ///手机效果图
    var phone = Image.asset(
      'assets/image/img_download_phone.png',
      width: 260,
    );

    ///顶部小鸟+白云
    var bird = Image.asset(
      'assets/image/img_download_bird.png',
      width: 60,
    );

    ///下载文字介绍
    var text = Image.asset(
      'assets/image/img_download_text.png',
      width: 220,
    );

    ///Android+iOS下载图标
    var mobile = Image.asset(
      'assets/image/img_download_mobile.png',
      width: 160,
    );

    ///底部背景
    var bottom = Image.asset(
      'assets/image/img_download_bottom.png',
      height: 120,
    );
    var qr = BasisProviderWidget<DownloadAppViewModel>(
      model: DownloadAppViewModel(),
      onModelReady: (_) => _.checkRunPlatform(),
      builder: (context, model, child) => InkWell(
        child: NetworkImageLoader(
          url: AppConstant.downloadApkQrUrl,
          width: 180,
          height: 180,
        ),
        onTap: () => openUrl(AppConstant.downloadApkUrl),
      ),
    );
    var download = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        bird,
        text,
        mobile,
        SizedBox(
          height: getSpaceSmall(),
        ),
        qr,
      ],
    );
    return Theme(
      data: AppThemeData.darkThemeData,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: LogoHeader(
                  showAlways: true,
                ),
              ),
              Button(
                backgroundColor: AppThemeData.darkThemeData.colorScheme.secondary,
                paddingLeft: getSpaceSmall(),
                paddingRight: getSpaceSmall(),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.home,
                  (route) => false,
                ),
                child: Text(
                  appString.backToIndex,
                ),
              ),
              SizedBox(
                width: getSpaceSmall(),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: isSmallDisplay
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      phone,
                      download,
                      bottom,
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [phone, download],
                      ),
                    ),
                    bottom,
                  ],
                ),
        ),
      ),
    );
  }
}
