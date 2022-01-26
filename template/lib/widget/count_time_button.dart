import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/view_model/count_time_view_model.dart';
import 'package:flutter_fast_lib_template/widget/button.dart';
import 'package:flutter_fast_lib_template/widget/windmill_indicator.dart';

///倒计时按钮
class CountTimeButton extends StatelessWidget {
  final WillPopCallback onClick;
  final String? text;
  final int timeMax;
  final int timeInterval;
  final EdgeInsetsGeometry? margin;

  const CountTimeButton({
    Key? key,
    required this.onClick,
    this.text,
    this.timeMax = 60,
    this.timeInterval = 1,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasisProviderWidget<CountTimeViewModel>(
      model: CountTimeViewModel(
        timeMax: timeMax,
        interval: timeInterval,
      ),
      builder: (context, model, child) => Button(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(model.isFinish ? 1.0 : 0.6),
        fontSize: 13,
        child: model.loading
            ? const WindmillIndicator.mini()
            : Text(
                model.isFinish
                    ? text ?? appString.getVerificationCode
                    : '${model.currentTime}${appString.reGetAfter}',
              ),
        onPressed: model.isFinish
            ? () async {
                model.setLoading();
                bool? result;
                try {
                  result = await onClick.call();
                } catch (e, stack) {
                  FastLogUtil.e('error:$e', tag: 'CountTimeButtonTag');
                  model.setError(e, stack);
                }
                model.setSuccess();
                if (true == result) {
                  model.startCountDown();
                }
              }
            : null,
      ),
    );
  }
}
