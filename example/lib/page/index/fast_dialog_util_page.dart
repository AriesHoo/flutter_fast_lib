
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/web_view_page.dart';
import 'package:flutter_fast_lib_example/widget/info_card.dart';

///[FastDialogUtil] 示例
class FastDialogUtilPage extends StatelessWidget {
  const FastDialogUtilPage({Key? key}) : super(key: key);
  final String info = "FastDialogUtil提供AlertDialog及CupertinoAlertDialog快速弹框。"
      "\n1、提供FastPlatformType(adaptive-自适应平台;material-AlertDialog;cupertino-CupertinoAlertDialog);";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastDialogUtil示例'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(info: info),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastDialogUtil.showAlertDialog(
                    title: '用户协议及隐私条款',
                    cancel: '取消',
                    ensure: '同意',
                    contentWidget: const UserAgreement(),
                    platformType: FastPlatformType.adaptive,
                  );
                  FastToastUtil.showSuccess('result:$result');
                },
                child: const Text('showAlertDialog-adaptive'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastDialogUtil.showAlertDialog(
                    title: '用户协议及隐私条款',
                    cancel: '取消',
                    ensure: '同意',
                    contentWidget: const UserAgreement(),
                    platformType: FastPlatformType.material,
                  );
                  FastToastUtil.showSuccess('result:$result');
                },
                child: const Text('showAlertDialog-material'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await FastDialogUtil.showAlertDialog(
                    title: '用户协议及隐私条款',
                    cancel: '取消',
                    ensure: '同意',
                    contentWidget: const UserAgreement(),
                    platformType: FastPlatformType.cupertino,
                  );
                  FastToastUtil.showSuccess('result:$result');
                },
                child: const Text('showAlertDialog-cupertino'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///用户协议及隐私条款
class UserAgreement extends StatelessWidget {
  const UserAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).textTheme.headline6!.color!;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        text:
            '欢迎来到FlutterFastLib!\n为了更好地保护您的权益，在此为您介绍在服务的过程中我们将如何规范安全地收集、存储、保护、使用及对外提供您的信息，请您充分了解:'
            '\n   • 为保障APP稳定运行或为您提供个性化服务体验(例如:服务机构地图)，FlutterFastLib APP需要申请必要的手机权限(例如:定位权限)。当您开启权限后，FlutterFastLibAPP才会收集必要的信息。'
            '\n   • 为采取风险防范措施保障您的账户安全，并依法履行实名制管理等监管义务，我们需要在必要范围内收集您的身份基本信息、账户信息以及设备信息。',
        children: [
          TextSpan(
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
            text: '\n\n更多详情，敬请查阅',
          ),
          TextSpan(
            text: '《用户协议及隐私条款》',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => WebViewPage.start(initialUrl: 'http://www.baidu.com'),
          ),
          TextSpan(
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
            text: '全文。我们承诺:将以业界领先的信息安全保护水平，全力保护您的信息安全!',
          ),
        ],
      ),
    );
  }
}
