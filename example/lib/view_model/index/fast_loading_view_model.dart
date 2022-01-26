import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_example/page/index/fast_loading_page.dart';

///[FastLoadingPage]
class FastLoadingViewModel extends BasisViewModel {
  bool _showText = false;
  bool _clickClose = true;
  bool _allowClick = false;
  bool _builder = false;

  bool get showText => _showText;

  setShowText(bool value) {
    _showText = value;
    setSuccess();
  }

  bool get clickClose => _clickClose;

  setClickClose(bool value) {
    _clickClose = value;
    setSuccess();
  }

  bool get allowClick => _allowClick;

  setAllowClick(bool value) {
    _allowClick = value;
    setSuccess();
  }

  bool get builder => _builder;

  setBuilder(bool value) {
    _builder = value;
    setSuccess();
  }
}
