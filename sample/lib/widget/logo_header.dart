import 'package:flutter/material.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///顶部logo
class LogoHeader extends StatelessWidget {
  final bool showAlways;

  const LogoHeader({
    Key? key,
    this.showAlways = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;
    var ratio = isSmallDisplay ? MediaQuery.of(context).size.width / 540 : 1.0;

    FastLogUtil.e(
        'LogoHeaderWidth:${MediaQuery.of(context).size.width};isSmallDisplay:$isSmallDisplay}');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/img_logo.png',
            width: 42 * ratio,
            height: 42 * ratio,
          ),
          Image.asset(
            'assets/image/img_logo_font${darkMode ? '_white' : ''}.png',
            height: 54 * ratio,
          ),
        ],
      ),
    );
  }
}
