import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/list_pagination/error_view.dart';
import 'package:skybase/ui/widgets/list_pagination/list_empty_view.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyListView extends StatelessWidget {
  /// Can override setting Visibility emptyView even if [emptyEnabled] is true
  final bool visibleOnEmpty;

  /// Can override setting Visibility emptyView even if [errorEnabled] is true
  final bool visibleOnError;

  /// Show [loadingView] when set to *true*
  final bool loadingEnabled;

  /// Show [emptyView] when set to *true*
  final bool emptyEnabled;

  /// Show [errorView] when set to *true*
  final bool errorEnabled;

  /// Loading view that will show if [loadingEnabled] is true
  final Widget? loadingView;

  /// Image that will show if [emptyEnabled] is true
  final Widget? emptyImageWidget;

  final String? emptyImage;

  /// Title that will show if [emptyEnabled] is true
  final String? emptyTitle;

  /// Subtitle that will show if [emptyEnabled] is true
  final String? emptySubtitle;

  /// Image that will show if [errorEnabled] is true
  final Widget? errorImageWidget;

  final String? errorImage;

  /// Title that will show if [errorEnabled] is true
  final String? errorTitle;

  /// Subtitle that will show if [errorEnabled] is true
  final String? errorSubtitle;

  /// Set scrollable of your empty/error view
  final bool isComponent;

  final String? retryText;

  final Widget? retryWidget;

  /// Function to controll onPress 'retry' if [errorEnabled] is true
  final void Function()? onRetry;

  final Widget? emptyView;

  final Widget child;

  final VoidCallback? onRefresh;

  final double? imageSize;

  final double? verticalSpacing;

  final double? horizontalSpacing;

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  const SkyListView({
    Key? key,
    required this.emptyEnabled,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.onRetry,
    required this.child,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.loadingView,
    this.visibleOnEmpty = true,
    this.visibleOnError = true,
    this.errorImageWidget,
    this.errorSubtitle,
    this.errorTitle,
    this.isComponent = true,
    this.emptyView,
    this.retryText,
    this.onRefresh,
    this.imageSize,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.titleStyle,
    this.subtitleStyle,
    this.errorImage,
    this.retryWidget,
    this.emptyImageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loadingWidget = loadingView ?? const ShimmerList();

    return Stack(
      children: [
        if (!loadingEnabled && !emptyEnabled & !errorEnabled) getBodyWidget(),
        if (visibleOnError && errorEnabled) getErrorView(),
        if (visibleOnEmpty && emptyEnabled && !errorEnabled && !loadingEnabled)
          getEmptyView(),
        if (loadingEnabled) getLoadingView(loadingWidget),
      ],
    );
  }

  Widget getBodyWidget() {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () => Future.sync(onRefresh!),
        child: child,
      );
    } else {
      return child;
    }
  }

  Widget getLoadingView(Widget loadingWidget) {
    return Center(
      child: AnimatedOpacity(
        opacity: loadingEnabled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: loadingWidget,
      ),
    );
  }

  Widget getEmptyView() {
    return emptyView ??
        ListEmptyView(
          emptyImage: emptyImage,
          emptyImageWidget: emptyImageWidget,
          emptyTitle: emptyTitle,
          emptySubtitle: emptySubtitle,
          isScrollable: isComponent,
          imageSize: imageSize,
          horizontalSpacing: horizontalSpacing ?? 24,
          verticalSpacing: verticalSpacing ?? 24,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
        );
  }

  Widget getErrorView() {
    return ErrorView(
      errorImage: errorImage,
      errorImageWidget: errorImageWidget,
      errorTitle: errorTitle,
      errorSubtitle: errorSubtitle,
      onRetry: onRetry,
      retryText: retryText,
      isScrollable: isComponent,
      imageSize: imageSize,
      horizontalSpacing: horizontalSpacing ?? 24,
      verticalSpacing: verticalSpacing ?? 24,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      retryWidget: retryWidget,
    );
  }
}
