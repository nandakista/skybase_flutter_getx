/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

import '../empty_config.dart';
import '../empty_view.dart';
import '../error_config.dart';
import '../error_view.dart';

part 'request_state.dart';

class StateView extends StatelessWidget {
  final RequestState state;

  final EmptyConfig? emptyConfig;
  final ErrorConfig? errorConfig;

  final Widget? loadingView;
  final Widget? errorView;
  final Widget? emptyView;
  final List<Widget>? footerSliver;
  final List<Widget>? headerSliver;

  final Widget child;
  final void Function()? onRetry;
  final Future<void> Function()? onRefresh;
  final bool isComponent;
  final bool forceiOSStyle;
  final bool forceAndroidStyle;
  final double displacement;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool? addRepaintBoundaries;
  final bool? addSemanticIndexes;
  final double? cacheExtent;
  final Clip? clipBehavior;
  final DragStartBehavior? dragStartBehavior;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? primary;
  final bool? reverse;
  final ScrollController? scrollController;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;
  final int? semanticChildCount;
  final double? anchor;
  final Key? center;

  const StateView.page({
    super.key,
    required this.state,
    required this.onRetry,
    required this.child,
    this.emptyConfig,
    this.errorConfig,
    this.errorView,
    this.emptyView,
    this.loadingView,
    this.isComponent = false,
    this.onRefresh,
    this.footerSliver,
    this.headerSliver,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.clipBehavior,
    this.dragStartBehavior,
    this.itemExtent,
    this.keyboardDismissBehavior,
    this.primary,
    this.reverse,
    this.scrollController,
    this.restorationId,
    this.scrollBehavior,
    this.semanticChildCount,
    this.anchor,
    this.center,
    this.forceiOSStyle = false,
    this.forceAndroidStyle = false,
    this.displacement = 40,
  });

  const StateView.component({
    super.key,
    required this.state,
    required this.onRetry,
    required this.child,
    this.emptyConfig,
    this.errorConfig,
    this.errorView,
    this.emptyView,
    this.loadingView,
    this.isComponent = true,
    this.footerSliver,
    this.headerSliver,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.clipBehavior,
    this.dragStartBehavior,
    this.itemExtent,
    this.keyboardDismissBehavior,
    this.primary,
    this.reverse,
    this.scrollController,
    this.restorationId,
    this.scrollBehavior,
    this.semanticChildCount,
    this.anchor,
    this.center,
  }) : onRefresh = null,
       forceiOSStyle = false,
       forceAndroidStyle = false,
       displacement = 40;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      RequestState.initial => const SizedBox.shrink(),
      RequestState.empty => _getEmptyView(context),
      RequestState.error => _getErrorView(context),
      RequestState.loading ||
      RequestState.success => getLoadingAndBodyView(context),
    };
  }

  Widget getLoadingAndBodyView(BuildContext context) {
    if (isComponent || onRefresh == null) {
      return state.isLoading
          ? _getLoadingView(loadingView ?? const PlatformLoadingIndicator())
          : child;
    } else {
      return Platform.isIOS && (forceiOSStyle || !forceAndroidStyle)
          ? _iosObjectView(onRefresh: onRefresh!)
          : _androidObjectView(onRefresh: onRefresh!);
    }
  }

  Widget _androidObjectView({required VoidCallback onRefresh}) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(onRefresh),
      displacement: displacement,
      child: CustomScrollView(
        shrinkWrap: shrinkWrap,
        physics: physics,
        scrollDirection: scrollDirection,
        scrollBehavior: scrollBehavior,
        controller: scrollController,
        keyboardDismissBehavior:
            keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse ?? false,
        semanticChildCount: semanticChildCount,
        anchor: anchor ?? 0.0,
        center: center,
        slivers: [
          if (headerSliver != null && !state.isLoading) ...headerSliver!,
          (!state.isLoading)
              ? SliverToBoxAdapter(child: child)
              : SliverFillRemaining(
                  hasScrollBody: false,
                  child: _getLoadingView(
                    loadingView ?? const PlatformLoadingIndicator(),
                  ),
                ),
          if (footerSliver != null && !state.isLoading) ...footerSliver!,
        ],
      ),
    );
  }

  Widget _iosObjectView({required VoidCallback onRefresh}) {
    return CustomScrollView(
      shrinkWrap: shrinkWrap,
      physics: physics,
      scrollDirection: scrollDirection,
      scrollBehavior: scrollBehavior,
      controller: scrollController,
      keyboardDismissBehavior:
          keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse ?? false,
      semanticChildCount: semanticChildCount,
      anchor: anchor ?? 0.0,
      center: center,
      slivers: [
        if (headerSliver != null && !state.isLoading) ...headerSliver!,
        CupertinoSliverRefreshControl(onRefresh: () => Future.sync(onRefresh)),
        (!state.isLoading)
            ? SliverToBoxAdapter(child: child)
            : SliverFillRemaining(
                child: _getLoadingView(
                  loadingView ?? const PlatformLoadingIndicator(),
                ),
              ),
        if (footerSliver != null && !state.isLoading) ...footerSliver!,
      ],
    );
  }

  Widget _getLoadingView(Widget loadingWidget) {
    return !state.isLoading
        ? const SizedBox.shrink()
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: loadingWidget,
          );
  }

  Widget _getEmptyView(BuildContext context) {
    return emptyView ??
        EmptyView(
          emptyImage: emptyConfig?.image,
          emptyImageWidget: emptyConfig?.imageWidget,
          emptyTitle: emptyConfig?.title,
          emptySubtitle: emptyConfig?.subtitle,
          imageHeight: emptyConfig?.imageHeight,
          imageWidth: emptyConfig?.imageWidth,
          horizontalSpacing: emptyConfig?.horizontalSpacing ?? 24,
          verticalSpacing: emptyConfig?.verticalSpacing ?? 24,
          titleStyle: emptyConfig?.titleStyle,
          subtitleStyle: emptyConfig?.subtitleStyle,
          retryWidget: emptyConfig?.retryWidget,
          onRetry: onRetry ?? onRefresh ?? emptyConfig?.onRetry,
          retryText: emptyConfig?.retryText,
          emptyRetryEnabled: emptyConfig?.retryEnabled ?? false,
        );
  }

  Widget _getErrorView(BuildContext context) {
    return errorView ??
        ErrorView(
          errorImage: errorConfig?.image,
          errorImageWidget: errorConfig?.imageWidget,
          errorTitle: errorConfig?.title,
          errorSubtitle: errorConfig?.subtitle,
          onRetry: onRetry ?? onRefresh ?? errorConfig?.onRetry,
          retryText: errorConfig?.retryText,
          imageHeight: errorConfig?.imageHeight,
          imageWidth: errorConfig?.imageWidth,
          horizontalSpacing: errorConfig?.horizontalSpacing ?? 24,
          verticalSpacing: errorConfig?.verticalSpacing ?? 24,
          titleStyle: errorConfig?.titleStyle,
          subtitleStyle: errorConfig?.subtitleStyle,
          retryWidget: errorConfig?.retryWidget,
        );
  }
}
