import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:url_launcher/url_launcher.dart';

///web项目信息
WebBrowserInfo? webBrowserInfo;

///手机端判断userAgent
String _mobileUserAgent =
    'phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone';

///Android判断userAgent
String _androidUserAgent = 'Android';

///iOS判断userAgent
String _iOSUserAgent = 'phone|pad|pod|iPhone|iPod|ios|iPad';

///是否运行在手机上
bool get runOnMobile =>
    FastPlatformUtil.isMobile ||
    (webBrowserInfo != null &&
        webBrowserInfo!.userAgent != null &&
        _mobileUserAgent.split('|').any(
              (element) => webBrowserInfo!.userAgent!.contains(element),
            ));

///是否运行在Android上
bool get runOnAndroid =>
    FastPlatformUtil.isAndroid ||
    (webBrowserInfo != null &&
        webBrowserInfo!.userAgent != null &&
        _androidUserAgent.split('|').any(
              (element) => webBrowserInfo!.userAgent!.contains(element),
            ));

///是否运行在iOS上
bool get runOniOS =>
    FastPlatformUtil.isIOS ||
    (webBrowserInfo != null &&
        webBrowserInfo!.userAgent != null &&
        _iOSUserAgent.split('|').any(
              (element) => webBrowserInfo!.userAgent!.contains(element),
            ));

///转int
int? parseInt(dynamic value) {
  try {
    return int.parse(value.toString());
  } catch (e) {
    return null;
  }
}

///转Double
double? parseDouble(dynamic value) {
  try {
    return double.parse(value.toString());
  } catch (e) {
    return null;
  }
}

///打开url
void openUrl(String url) async {
  try {
    bool can = await canLaunch(url);
    if (can) {
      await launch(url);
    } else {}
  } catch (e) {
    FastLogUtil.e('e:$e', tag: 'openUrlTag');
  }
}

///找出两个字符的公共部分-主要用于Edit 过滤器
getSameStr(String first, String second, String regex) {
  String result = '';

  ///都不为空再进行遍历
  if (!TextUtil.isEmpty(first) && !TextUtil.isEmpty(second)) {
    List<String> listFirst = first.split('');
    List<String> listSecond = first.split('');
    List<String> listTarget =
        listFirst.length <= listSecond.length ? listFirst : listSecond;

    for (var i = 0; i < listTarget.length; i++) {
      if (listFirst[i] == listSecond[i] &&
          !RegexUtil.matches(regex, listFirst[i])) {
        result += listFirst[i];
      }
    }
  }
  return result;
}

///是否为正确的密码
bool isPassword(String password) {
  return RegexUtil.matches(
      "^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{8,16}\$", password);
}
///将时间转换为XX天XX小时XX分钟XX秒前
String timeStr(String? time) {
  String result = time ?? '';
  DateTime? createDateTime;
  try {
    createDateTime = DateTime.parse(result).toLocal();
    result = TimelineUtil.formatByDateTime(
      createDateTime,
      dayFormat: DayFormat.Full,
      locale: 'zh',
    );
  } catch (e) {
    FastLogUtil.e('e:$e');
  }
  return result;
}
