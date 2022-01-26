import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:logger/logger.dart';

///Logger工具类封装
class FastLogUtil {
  static Logger _logger = Logger();

  ///debug模式下才打印日志
  static bool _debugModel = false;
  static String _logTag = 'FastLogUtil';

  ///初始化
  static _init() {
    _debugModel = FastManager.getInstance().logMixin.debug;
    _logTag = FastManager.getInstance().logMixin.tag;
    _logger = FastManager.getInstance().logMixin.logger ??
        Logger(
          printer: PrettyPrinter(
            stackTraceBeginIndex:
                FastManager.getInstance().logMixin.stackTraceBeginIndex,
            methodCount: FastManager.getInstance().logMixin.methodCount,
            errorMethodCount:
                FastManager.getInstance().logMixin.errorMethodCount,
            lineLength: FastManager.getInstance().logMixin.lineLength,

            ///colors not support see https://github.com/leisim/logger/issues/2
            colors: FastManager.getInstance().logMixin.colors,
            printEmojis: FastManager.getInstance().logMixin.printEmojis,
            printTime: FastManager.getInstance().logMixin.printTime,
          ),
        );
  }

  static v(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.v(
      '${tag ?? _logTag} | $message',
    );
  }

  static d(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.d(
      '${tag ?? _logTag} | $message',
    );
  }

  static i(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.i(
      '${tag ?? _logTag} | $message',
    );
  }

  static w(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.w(
      '${tag ?? _logTag} | $message',
    );
  }

  static e(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.e(
      '${tag ?? _logTag} | $message',
    );
  }

  static wtf(
    dynamic message, {
    String? tag,
  }) {
    _init();
    if (!_debugModel) {
      return;
    }
    _logger.wtf(
      '${tag ?? _logTag} | $message',
    );
  }
}
