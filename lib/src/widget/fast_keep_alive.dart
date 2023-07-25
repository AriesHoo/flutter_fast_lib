import 'package:flutter/material.dart';

///AutomaticKeepAliveClientMixin简单封装
class FastKeepAlive extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const FastKeepAlive({
    Key? key,
    required this.child,
    this.keepAlive = true,
  }) : super(key: key);

  @override
  State<FastKeepAlive> createState() => _FastKeepAliveState();
}

class _FastKeepAliveState extends State<FastKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
