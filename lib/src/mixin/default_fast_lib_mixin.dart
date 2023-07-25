import 'package:flutter_fast_lib/src/mixin/fast_adaptive_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_dialog_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_loading_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_log_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_network_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_quit_app_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_refresh_list_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_text_mixin.dart';
import 'package:flutter_fast_lib/src/mixin/fast_toast_mixin.dart';

DefaultFastLibMixin defaultFastLibMixin = DefaultFastLibMixin();

///FastLib 默认配置管理--方便修改部分数据
///[FastManager]
class DefaultFastLibMixin
    with
        FastNetworkMixin,
        FastRefreshListMixin,
        FastTextMixin,
        FastQuitAppMixin,
        FastAdaptiveMixin,
        FastDialogMixin,
        FastLogMixin,
        FastToastMixin,
        FastLoadingMixin {}
