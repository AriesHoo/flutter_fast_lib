// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("血染钟楼"),
        "backToIndex": MessageLookupByLibrary.simpleMessage("返回入口"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "detail": MessageLookupByLibrary.simpleMessage("详情"),
        "dialogTitle": MessageLookupByLibrary.simpleMessage("温馨提示"),
        "downloadApp": MessageLookupByLibrary.simpleMessage("下载App"),
        "ensure": MessageLookupByLibrary.simpleMessage("确定"),
        "gameRule": MessageLookupByLibrary.simpleMessage("游戏规则"),
        "getVerificationCode": MessageLookupByLibrary.simpleMessage("获取验证码"),
        "homePage": MessageLookupByLibrary.simpleMessage("首页"),
        "httpErrorMessage": MessageLookupByLibrary.simpleMessage(
            "网络错误,请检查您的网络或是否禁用血染钟楼使用网络并稍后重试!"),
        "httpServiceErrorMessage": MessageLookupByLibrary.simpleMessage(
            "服务器错误,无法链接云平台!(502 Bad Gateway)"),
        "index": MessageLookupByLibrary.simpleMessage("首页"),
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "reGetAfter": MessageLookupByLibrary.simpleMessage("秒后重新获取"),
        "tipCannotInputEmojiStr":
            MessageLookupByLibrary.simpleMessage("不能输入表情"),
        "tipCannotInputSpecialStr":
            MessageLookupByLibrary.simpleMessage("不能输入特殊字符"),
        "tokenErrorMessage":
            MessageLookupByLibrary.simpleMessage("用户信息过期,请重新登录!"),
        "viewStateEmpty": MessageLookupByLibrary.simpleMessage("暂无内容"),
        "viewStateError": MessageLookupByLibrary.simpleMessage("加载失败"),
        "viewStateNetworkError":
            MessageLookupByLibrary.simpleMessage("网络好像不给力哟！"),
        "viewStateRefresh": MessageLookupByLibrary.simpleMessage("刷新一下"),
        "viewStateRetry": MessageLookupByLibrary.simpleMessage("重试一下")
      };
}
