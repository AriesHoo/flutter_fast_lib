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

  /// `数字警察`
  String get appName {
    return Intl.message(
      '数字警察',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get homePage {
    return Intl.message(
      '首页',
      name: 'homePage',
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

  /// `网络错误,请检查您的网络或是否禁用数字警察使用网络并稍后重试!`
  String get httpErrorMessage {
    return Intl.message(
      '网络错误,请检查您的网络或是否禁用数字警察使用网络并稍后重试!',
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

  /// `温馨提示`
  String get dialogTitle {
    return Intl.message(
      '温馨提示',
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

  /// `获取验证码`
  String get getVerificationCode {
    return Intl.message(
      '获取验证码',
      name: 'getVerificationCode',
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

  /// `下载App`
  String get downloadApp {
    return Intl.message(
      '下载App',
      name: 'downloadApp',
      desc: '',
      args: [],
    );
  }

  /// `游戏规则`
  String get gameRule {
    return Intl.message(
      '游戏规则',
      name: 'gameRule',
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
