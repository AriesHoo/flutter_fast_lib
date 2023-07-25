import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Provider简单抽离方便数据初始化
class BasisProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;
  final Function(T)? onModelReady;

  const BasisProviderWidget({
    Key? key,
    required this.model,
    required this.builder,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  State<BasisProviderWidget<T>> createState() => _BasisProviderWidgetState<T>();
}

class _BasisProviderWidgetState<T extends ChangeNotifier>
    extends State<BasisProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

///2个model
class BasisProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A m1, B m2, Widget? child)
      builder;
  final A m1;
  final B m2;
  final Widget? child;
  final Function(A, B)? onModelReady;

  const BasisProviderWidget2({
    Key? key,
    required this.builder,
    required this.m1,
    required this.m2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  State<BasisProviderWidget2<A, B>> createState() =>
      _BasisProviderWidgetState2<A, B>();
}

class _BasisProviderWidgetState2<A extends ChangeNotifier,
    B extends ChangeNotifier> extends State<BasisProviderWidget2<A, B>> {
  @override
  void initState() {
    widget.onModelReady?.call(widget.m1, widget.m2);
    super.initState();
  }

  @override
  void dispose() {
    widget.m1.dispose();
    widget.m2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: widget.m1),
          ChangeNotifierProvider<B>.value(value: widget.m2),
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
