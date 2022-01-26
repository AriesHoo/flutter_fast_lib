import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/src/fast_manager.dart';
import 'package:flutter_fast_lib/src/widget/state/fast_state_widget.dart';

///空数据视图--如果无全局、无局部则使用该内置效果
class FastEmptyStateWidget extends StatelessWidget {
  final String? message;
  final GestureTapCallback? onPressed;

  const FastEmptyStateWidget({
    Key? key,
    this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FastStateWidget(
      image: const Icon(
        Icons.hourglass_empty,
        size: 80,
        color: Colors.grey,
      ),
      message: Text(
          message ?? FastManager.getInstance().textMixin.stateEmptyMessage),
      button: TextButton(
        onPressed: onPressed,
        child: Text(FastManager.getInstance().textMixin.stateRetryText),
      ),
    );
  }
}
