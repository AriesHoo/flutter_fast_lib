// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `flutter_fast_lib_template_web`
  String get appName {
    return Intl.message(
      'flutter_fast_lib_template_web',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `加载失败`
  String get viewStateError {
    return Intl.message(
      '加载失败',
      name: 'viewStateError',
      desc: '',
      args: [],
    );
  }

  /// `网络好像不给力哟！`
  String get viewStateNetworkError {
    return Intl.message(
      '网络好像不给力哟！',
      name: 'viewStateNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `暂无内容`
  String get viewStateEmpty {
    return Intl.message(
      '暂无内容',
      name: 'viewStateEmpty',
      desc: '',
      args: [],
    );
  }

  /// `刷新一下`
  String get viewStateRefresh {
    return Intl.message(
      '刷新一下',
      name: 'viewStateRefresh',
      desc: '',
      args: [],
    );
  }

  /// `重试一下`
  String get viewStateRetry {
    return Intl.message(
      '重试一下',
      name: 'viewStateRetry',
      desc: '',
      args: [],
    );
  }

  /// `用户信息过期,请重新登录!`
  String get tokenErrorMessage {
    return Intl.message(
      '用户信息过期,请重新登录!',
      name: 'tokenErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `网络错误,请检查您的网络或是否禁用特教云使用网络并稍后重试!`
  String get httpErrorMessage {
    return Intl.message(
      '网络错误,请检查您的网络或是否禁用特教云使用网络并稍后重试!',
      name: 'httpErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `服务器错误,无法链接云平台!(502 Bad Gateway)`
  String get httpServiceErrorMessage {
    return Intl.message(
      '服务器错误,无法链接云平台!(502 Bad Gateway)',
      name: 'httpServiceErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `不能输入特殊字符`
  String get tipCannotInputSpecialStr {
    return Intl.message(
      '不能输入特殊字符',
      name: 'tipCannotInputSpecialStr',
      desc: '',
      args: [],
    );
  }

  /// `不能输入表情`
  String get tipCannotInputEmojiStr {
    return Intl.message(
      '不能输入表情',
      name: 'tipCannotInputEmojiStr',
      desc: '',
      args: [],
    );
  }

  /// `特教云提示`
  String get dialogTitle {
    return Intl.message(
      '特教云提示',
      name: 'dialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `详情`
  String get detail {
    return Intl.message(
      '详情',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `关闭`
  String get close {
    return Intl.message(
      '关闭',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get ensure {
    return Intl.message(
      '确定',
      name: 'ensure',
      desc: '',
      args: [],
    );
  }

  /// `返回入口`
  String get backToIndex {
    return Intl.message(
      '返回入口',
      name: 'backToIndex',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get index {
    return Intl.message(
      '首页',
      name: 'index',
      desc: '',
      args: [],
    );
  }

  /// `课程中心`
  String get courseCenter {
    return Intl.message(
      '课程中心',
      name: 'courseCenter',
      desc: '',
      args: [],
    );
  }

  /// `新闻资讯`
  String get newsInfo {
    return Intl.message(
      '新闻资讯',
      name: 'newsInfo',
      desc: '',
      args: [],
    );
  }

  /// `新闻公告`
  String get newsNotice {
    return Intl.message(
      '新闻公告',
      name: 'newsNotice',
      desc: '',
      args: [],
    );
  }

  /// `下载APP`
  String get downloadApp {
    return Intl.message(
      '下载APP',
      name: 'downloadApp',
      desc: '',
      args: [],
    );
  }

  /// `意见反馈`
  String get feedback {
    return Intl.message(
      '意见反馈',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `反馈内容`
  String get feedbackContent {
    return Intl.message(
      '反馈内容',
      name: 'feedbackContent',
      desc: '',
      args: [],
    );
  }

  /// `不能为空`
  String get inputCannotEmpty {
    return Intl.message(
      '不能为空',
      name: 'inputCannotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!`
  String get feedbackSucceed {
    return Intl.message(
      '反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!反馈成功,非常感觉您对我们提出宝贵的意见!',
      name: 'feedbackSucceed',
      desc: '',
      args: [],
    );
  }

  /// `提交`
  String get submit {
    return Intl.message(
      '提交',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `成都市特殊教育资源中心`
  String get resourceCenter {
    return Intl.message(
      '成都市特殊教育资源中心',
      name: 'resourceCenter',
      desc: '',
      args: [],
    );
  }

  /// `蜀ICP备09003940号`
  String get recordNo {
    return Intl.message(
      '蜀ICP备09003940号',
      name: 'recordNo',
      desc: '',
      args: [],
    );
  }

  /// `关于我们`
  String get aboutUs {
    return Intl.message(
      '关于我们',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `我们是干嘛的`
  String get whatWeDo {
    return Intl.message(
      '我们是干嘛的',
      name: 'whatWeDo',
      desc: '',
      args: [],
    );
  }

  /// `\n特教云平台是为成都市打造的特殊教育支持服务系统。具有新闻公告、今日课堂管理、个别化教育计划管理、服务呼叫管理、学习资源管理、消息提醒、师培空间、帮扶专区、服务机构地图等功能。`
  String get whatWeDoDesc {
    return Intl.message(
      '\n特教云平台是为成都市打造的特殊教育支持服务系统。具有新闻公告、今日课堂管理、个别化教育计划管理、服务呼叫管理、学习资源管理、消息提醒、师培空间、帮扶专区、服务机构地图等功能。',
      name: 'whatWeDoDesc',
      desc: '',
      args: [],
    );
  }

  /// `\n我们的目标`
  String get ourTarget {
    return Intl.message(
      '\n我们的目标',
      name: 'ourTarget',
      desc: '',
      args: [],
    );
  }

  /// `\n    1、为特教学校提供高效便捷的移动互联网管理平台\n    2、建设适合特殊儿童的课程资源和在线学习平台\n    3、为学校、家长、学生打造一个服务平台\n    4、促进全社会关心和帮助特殊儿童的教育、成长和生存`
  String get ourTargetDesc {
    return Intl.message(
      '\n    1、为特教学校提供高效便捷的移动互联网管理平台\n    2、建设适合特殊儿童的课程资源和在线学习平台\n    3、为学校、家长、学生打造一个服务平台\n    4、促进全社会关心和帮助特殊儿童的教育、成长和生存',
      name: 'ourTargetDesc',
      desc: '',
      args: [],
    );
  }

  /// `\n联系我们`
  String get contactUs {
    return Intl.message(
      '\n联系我们',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `\n    地址：成都市一环路北一段182号\n    邮编：610031`
  String get contactUsDesc {
    return Intl.message(
      '\n    地址：成都市一环路北一段182号\n    邮编：610031',
      name: 'contactUsDesc',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get login {
    return Intl.message(
      '登录',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `手机号码`
  String get loginAccount {
    return Intl.message(
      '手机号码',
      name: 'loginAccount',
      desc: '',
      args: [],
    );
  }

  /// `登录密码`
  String get loginPassword {
    return Intl.message(
      '登录密码',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `请输入正确的手机号码`
  String get tipEnterRightPhoto {
    return Intl.message(
      '请输入正确的手机号码',
      name: 'tipEnterRightPhoto',
      desc: '',
      args: [],
    );
  }

  /// `返回登录`
  String get backLogin {
    return Intl.message(
      '返回登录',
      name: 'backLogin',
      desc: '',
      args: [],
    );
  }

  /// `普通用户`
  String get normalLogin {
    return Intl.message(
      '普通用户',
      name: 'normalLogin',
      desc: '',
      args: [],
    );
  }

  /// `管理员`
  String get adminLogin {
    return Intl.message(
      '管理员',
      name: 'adminLogin',
      desc: '',
      args: [],
    );
  }

  /// `游客`
  String get visitorLogin {
    return Intl.message(
      '游客',
      name: 'visitorLogin',
      desc: '',
      args: [],
    );
  }

  /// `激活`
  String get activate {
    return Intl.message(
      '激活',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `激活账号`
  String get activateAccount {
    return Intl.message(
      '激活账号',
      name: 'activateAccount',
      desc: '',
      args: [],
    );
  }

  /// `请输入手机号码,通过手机验证码进行账号激活!`
  String get activateAccountDesc {
    return Intl.message(
      '请输入手机号码,通过手机验证码进行账号激活!',
      name: 'activateAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `请输入姓名及身份证号,通过验证后账号激活!`
  String get activateAccountNextStepDesc {
    return Intl.message(
      '请输入姓名及身份证号,通过验证后账号激活!',
      name: 'activateAccountNextStepDesc',
      desc: '',
      args: [],
    );
  }

  /// `去激活`
  String get activateNow {
    return Intl.message(
      '去激活',
      name: 'activateNow',
      desc: '',
      args: [],
    );
  }

  /// `忘记密码`
  String get forgetPassword {
    return Intl.message(
      '忘记密码',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `请输入手机号码,通过手机验证码进行密码重置!`
  String get forgetPasswordDesc {
    return Intl.message(
      '请输入手机号码,通过手机验证码进行密码重置!',
      name: 'forgetPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `请输入登录密码及确认密码,通过验证后密码重置!`
  String get forgetPasswordNextDesc {
    return Intl.message(
      '请输入登录密码及确认密码,通过验证后密码重置!',
      name: 'forgetPasswordNextDesc',
      desc: '',
      args: [],
    );
  }

  /// `验证码`
  String get verificationCode {
    return Intl.message(
      '验证码',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `获取验证码`
  String get getVerificationCode {
    return Intl.message(
      '获取验证码',
      name: 'getVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `验证码已发送成功,请注意查收!`
  String get tipSendVerificationCodeSucceed {
    return Intl.message(
      '验证码已发送成功,请注意查收!',
      name: 'tipSendVerificationCodeSucceed',
      desc: '',
      args: [],
    );
  }

  /// `请先输入手机号码并获取验证码!`
  String get tipEnterPhoneFirst {
    return Intl.message(
      '请先输入手机号码并获取验证码!',
      name: 'tipEnterPhoneFirst',
      desc: '',
      args: [],
    );
  }

  /// `下一步`
  String get nextStep {
    return Intl.message(
      '下一步',
      name: 'nextStep',
      desc: '',
      args: [],
    );
  }

  /// `上一步`
  String get previousStep {
    return Intl.message(
      '上一步',
      name: 'previousStep',
      desc: '',
      args: [],
    );
  }

  /// `秒后重新获取`
  String get reGetAfter {
    return Intl.message(
      '秒后重新获取',
      name: 'reGetAfter',
      desc: '',
      args: [],
    );
  }

  /// `原始密码`
  String get oldPassword {
    return Intl.message(
      '原始密码',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `新密码`
  String get newPassword {
    return Intl.message(
      '新密码',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `确认密码`
  String get confirmPassword {
    return Intl.message(
      '确认密码',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `两次输入的密码不一致!`
  String get passwordNotEqual {
    return Intl.message(
      '两次输入的密码不一致!',
      name: 'passwordNotEqual',
      desc: '',
      args: [],
    );
  }

  /// `密码必须为8-16位,且包含数字和字母!`
  String get passwordRule {
    return Intl.message(
      '密码必须为8-16位,且包含数字和字母!',
      name: 'passwordRule',
      desc: '',
      args: [],
    );
  }

  /// `找回密码成功,请使用新密码重新登录!`
  String get tipFindPasswordSucceed {
    return Intl.message(
      '找回密码成功,请使用新密码重新登录!',
      name: 'tipFindPasswordSucceed',
      desc: '',
      args: [],
    );
  }

  /// `姓名`
  String get name {
    return Intl.message(
      '姓名',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `身份证号`
  String get idCard {
    return Intl.message(
      '身份证号',
      name: 'idCard',
      desc: '',
      args: [],
    );
  }

  /// `请输入正确的身份证号!`
  String get idCardRule {
    return Intl.message(
      '请输入正确的身份证号!',
      name: 'idCardRule',
      desc: '',
      args: [],
    );
  }

  /// `账号激活成功,请使用账号及密码进行登录!`
  String get tipActivateSucceed {
    return Intl.message(
      '账号激活成功,请使用账号及密码进行登录!',
      name: 'tipActivateSucceed',
      desc: '',
      args: [],
    );
  }

  /// `师培空间`
  String get teacherTraining {
    return Intl.message(
      '师培空间',
      name: 'teacherTraining',
      desc: '',
      args: [],
    );
  }

  /// `帮扶专区`
  String get helpZone {
    return Intl.message(
      '帮扶专区',
      name: 'helpZone',
      desc: '',
      args: [],
    );
  }

  /// `今日课堂`
  String get todayClass {
    return Intl.message(
      '今日课堂',
      name: 'todayClass',
      desc: '',
      args: [],
    );
  }

  /// `个别化教育计划`
  String get iep {
    return Intl.message(
      '个别化教育计划',
      name: 'iep',
      desc: '',
      args: [],
    );
  }

  /// `服务呼叫`
  String get serviceCall {
    return Intl.message(
      '服务呼叫',
      name: 'serviceCall',
      desc: '',
      args: [],
    );
  }

  /// `更多`
  String get more {
    return Intl.message(
      '更多',
      name: 'more',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
