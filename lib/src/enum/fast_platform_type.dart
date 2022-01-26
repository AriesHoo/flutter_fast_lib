import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///UI平台类型
///[FastDialogUtil]
enum FastPlatformType {
  ///Android
  material,

  ///iOS
  cupertino,

  ///自适应平台 根据Theme.of(context).platform获取
  ///iOS及macOS--同cupertino 其它同--material
  adaptive,
}
