import 'dart:async';

import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///倒计时ViewModel
class CountTimeViewModel extends BasisViewModel {
  ///最大计时
  int timeMax;

  int interval;

  ///当前计时-默认值比max 大 interval;方便直接进入倒计时状态
  int _time = 0;

  CountTimeViewModel({this.timeMax = 60, this.interval = 1}) {
    _time = timeMax + interval;
  }

  Timer? _timer;

  int? get currentTime => _time;

  bool get isFinish => _time > timeMax;

  ///开始倒计时
  void startCountDown() {
    ///先减少为了使直接进行倒计时而不是过间隔时间再显示
    _time = _time - interval;
    notifyListeners();
    cancel();
    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      if (timer.tick == timeMax / interval) {
        _time = timeMax + interval;
        cancel();
      } else {
        _time = _time - interval;
      }
      notifyListeners();
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }
}
