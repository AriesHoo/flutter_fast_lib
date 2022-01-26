import 'dart:math';

import 'package:flutter/material.dart';

enum RotationDirection {
  clockwise,
  antiClockwise,
}

///风车旋转加载动画
///来源 https://gitee.com/island-coder/flutter-beginner/blob/master/animation/lib/windmill/windmill_indicator.dart#
///掘金 https://juejin.cn/post/7017545460176912392
class WindmillIndicator extends StatefulWidget {
  const WindmillIndicator.large({
    Key? key,
    this.size = 24.0,
    this.speed = 1.3,
    this.direction = RotationDirection.clockwise,
  }) : super(key: key);

  const WindmillIndicator.medium({
    Key? key,
    this.size = 16.0,
    this.speed = 1.0,
    this.direction = RotationDirection.clockwise,
  }) : super(key: key);

  const WindmillIndicator.small({
    Key? key,
    this.size = 12.0,
    this.speed = 1.0,
    this.direction = RotationDirection.clockwise,
  }) : super(key: key);

  const WindmillIndicator.mini({
    Key? key,
    this.size = 10.0,
    this.speed = 1.0,
    this.direction = RotationDirection.clockwise,
  }) : super(key: key);

  ///默认20.0
  final double size;

  /// 旋转速度-默认 1.2转/秒
  final double speed;
  final RotationDirection direction;

  const WindmillIndicator({
    Key? key,
    this.size = 20.0,
    this.speed = 1.2,
    this.direction = RotationDirection.clockwise,
  })  : assert(speed > 0),
        assert(size > 0),
        super(key: key);

  @override
  _WindmillIndicatorState createState() => _WindmillIndicatorState();
}

class _WindmillIndicatorState extends State<WindmillIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    int milliseconds = 1000 ~/ widget.speed;
    controller = AnimationController(
        duration: Duration(milliseconds: milliseconds), vsync: this);
    animation = Tween<double>(begin: 0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedWindmill(
      animation: animation,
      size: widget.size,
      direction: widget.direction,
    );
  }

  @override
  void dispose() {
    if (controller.status != AnimationStatus.completed &&
        controller.status != AnimationStatus.dismissed) {
      controller.stop();
    }

    controller.dispose();
    super.dispose();
  }
}

class AnimatedWindmill extends AnimatedWidget {
  final double size;
  final RotationDirection direction;

  const AnimatedWindmill({
    Key? key,
    required Animation<double> animation,
    required this.direction,
    this.size = 50.0,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    final rotationAngle = direction == RotationDirection.clockwise
        ? 2 * pi * animation.value
        : -2 * pi * animation.value;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        WindmillWing(
          size: size,
          color: Colors.blue,
          angle: 0 + rotationAngle,
        ),
        WindmillWing(
          size: size,
          color: Colors.yellow,
          angle: pi / 2 + rotationAngle,
        ),
        WindmillWing(
          size: size,
          color: Colors.green,
          angle: pi + rotationAngle,
        ),
        WindmillWing(
          size: size,
          color: Colors.red,
          angle: -pi / 2 + rotationAngle,
        ),
      ],
    );
  }
}

class WindmillWing extends StatelessWidget {
  final double size;
  final Color color;
  final double angle;

  const WindmillWing({
    Key? key,
    required this.size,
    required this.color,
    required this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transformAlignment: Alignment.bottomCenter,
      transform: Matrix4.translationValues(0, -size / 2, 0)..rotateZ(angle),
      child: ClipPath(
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          color: color,
        ),
        clipper: WindmillClipPath(),
      ),
    );
  }
}

class WindmillClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(size.width / 3, size.height)
      ..arcToPoint(
        Offset(0, size.height * 2 / 3),
        radius: Radius.circular(size.width / 2),
      )
      ..arcToPoint(
        Offset(size.width, 0),
        radius: Radius.circular(size.width),
      )
      ..lineTo(size.width / 3, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
