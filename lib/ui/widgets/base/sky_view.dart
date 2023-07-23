import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/list_pagination/error_view.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_detail.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyView extends StatelessWidget {
  const SkyView({
    Key? key,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.onRetry,
    required this.child,
    this.loadingView,
    this.errorView,
    this.errorTitle,
    this.errorSubtitle,
    this.errorImage,
    this.errorImageWidget,
    this.retryText,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.imageSize,
    this.errorTitleStyle,
    this.errorSubtitleStyle,
    this.retryWidget,
  }) : super(key: key);

  final bool loadingEnabled;
  final bool errorEnabled;
  final Widget? loadingView;
  final Widget? errorView;
  final Widget child;
  final String? errorTitle;
  final String? errorSubtitle;
  final VoidCallback onRetry;
  final String? errorImage;
  final Widget? errorImageWidget;
  final String? retryText;
  final double? verticalSpacing;
  final double? horizontalSpacing;
  final double? imageSize;
  final TextStyle? errorTitleStyle;
  final TextStyle? errorSubtitleStyle;
  final Widget? retryWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(onRetry),
        child: SingleChildScrollView(
          child: loadingEnabled
              ? loadingView ?? const ShimmerDetail()
              : (errorEnabled)
                  ? errorView ??
                      ErrorView(
                        isScrollable: false,
                        errorImage: errorImage,
                        errorImageWidget: errorImageWidget,
                        errorTitle: errorTitle,
                        errorSubtitle: errorSubtitle,
                        onRetry: onRetry,
                        titleStyle: errorTitleStyle,
                        subtitleStyle: errorSubtitleStyle,
                        imageSize: imageSize,
                        retryText: retryText,
                        retryWidget: retryWidget,
                        verticalSpacing: verticalSpacing ?? 24,
                        horizontalSpacing: horizontalSpacing ?? 24,
                      )
                  : child,
        ),
      ),
    );
  }
}
