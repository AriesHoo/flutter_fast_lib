
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/mixin/fast_lib_mixin.dart';

///
class FastToastViewModel extends BasisViewModel {
  bool _notification = fastLibMixin.notification;

  bool get notification => _notification;

  setNotification(bool value) {
    _notification = value;
    setSuccess();
  }
}
