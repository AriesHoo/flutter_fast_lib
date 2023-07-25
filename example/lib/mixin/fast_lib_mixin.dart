import 'package:flutter_fast_lib/flutter_fast_lib.dart';

FastLibMixin fastLibMixin = FastLibMixin();

///FastLib 默认配置管理--方便修改部分数据
///[FastManager]
class FastLibMixin extends DefaultFastLibMixin {
  @override
  String get tag => 'FastLibExample';

}
