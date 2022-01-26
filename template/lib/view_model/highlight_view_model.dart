import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///高亮变化
class HighlightViewModel extends BasisViewModel {
  bool _highlight = false;

  bool get highlight => _highlight;

  ValueChanged<bool> get onHighlightChanged => (highlight) {
        _highlight = highlight;
        setSuccess();
      };
}
