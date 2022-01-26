import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_lib_template/widget/windmill_indicator.dart';

///加载网络图片
class NetworkImageLoader extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final bool cache;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const NetworkImageLoader({
    Key? key,
    required this.url,
    this.width = double.infinity,
    this.height = double.infinity,
    this.cache = true,
    this.fit = BoxFit.fill,
    this.borderRadius,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///加载中...
    Widget loading = RoundWidget(
      child: Container(
        color: Theme.of(context).hintColor.withOpacity(0.1),
        width: width,
        height: height,
        child: Center(
          child: loadingWidget ?? const WindmillIndicator.mini(),
        ),
      ),
      borderRadius: borderRadius,
    );
    Widget error = RoundWidget(
      child: Container(
        color: Theme.of(context).hintColor.withOpacity(0.1),
        width: width,
        height: height,
        child: Center(
          child: errorWidget ?? const Icon(Icons.error_outline),
        ),
      ),
      borderRadius: borderRadius,
    );
    Widget image = ExtendedImage.network(
      url,
      height: height,
      width: width,
      fit: fit,
      enableSlideOutPage: true,
      cache: cache,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.5,
          // animationMinScale: 0.5,
          maxScale: 10,
          // animationMaxScale: 5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
        );
      },

      ///占位
      loadStateChanged: (state) =>
          state.extendedImageLoadState == LoadState.completed
              ? null
              : state.extendedImageLoadState == LoadState.loading
                  ? loading
                  : error,
    );
    return RoundWidget(
      child: image,
      borderRadius: borderRadius,
    );
  }
}

class RoundWidget extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;

  const RoundWidget({
    Key? key,
    required this.child,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return borderRadius == null
        ? child
        : ClipRRect(
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: child,
          );
  }
}
