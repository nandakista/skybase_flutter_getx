/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

import '../empty_config.dart';
import '../empty_view.dart';
import '../error_config.dart';
import '../error_view.dart';
import 'pagination_state.dart';

class PaginationGridView extends StatelessWidget {
  final EmptyConfig? emptyConfig;
  final ErrorConfig? errorConfig;

  final Widget? errorView;
  final Widget? emptyView;
  final Widget? loadingView;
  final Widget? loadingMoreView;
  final Widget? errorLoadMoreView;
  final List<Widget>? footerSliver;
  final List<Widget>? headerSliver;

  final PaginationState state;
  final void Function()? onRetry;
  final Future<void> Function()? onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback onLoadMore;
  final bool allLoaded;

  final SliverGridDelegate sliverGridDelegate;

  final bool forceiOSStyle;
  final bool forceAndroidStyle;
  final double displacement;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool? addAutomaticKeepAlives;
  final bool? addRepaintBoundaries;
  final bool? addSemanticIndexes;
  final double? cacheExtent;
  final Clip? clipBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? primary;
  final bool? reverse;
  final ScrollController? scrollController;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;
  final int? semanticChildCount;
  final double? anchor;
  final Key? center;

  const PaginationGridView({
    super.key,
    required this.state,
    required this.onLoadMore,
    required this.itemCount,
    required this.itemBuilder,
    required this.allLoaded,
    required this.sliverGridDelegate,
    this.onRetry,
    this.onRefresh,
    this.emptyConfig,
    this.errorConfig,
    this.errorView,
    this.emptyView,
    this.loadingMoreView,
    this.errorLoadMoreView,
    this.loadingView,
    this.footerSliver,
    this.headerSliver,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.addAutomaticKeepAlives,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.clipBehavior,
    this.dragStartBehavior,
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

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      PaginationState.initial => const SizedBox.shrink(),
      PaginationState.empty => _getEmptyView(context),
      PaginationState.error => _getErrorView(context),
      PaginationState.loading ||
      PaginationState.loadingMore ||
      PaginationState.errorMore ||
      PaginationState.success => _getLoadingAndBodyView(context),
    };
  }

  Widget _getLoadingAndBodyView(BuildContext context) {
    if (onRefresh == null) {
      return state.isLoading
          ? _getLoadingView(loadingView ?? const PlatformLoadingIndicator())
          : _buildGrid(null);
    } else {
      return Platform.isIOS && (forceiOSStyle || !forceAndroidStyle)
          ? _iosObjectView(onRefresh: onRefresh!)
          : _androidObjectView(onRefresh: onRefresh!);
    }
  }

  Widget _androidObjectView({required Future<void> Function() onRefresh}) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(onRefresh),
      displacement: displacement,
      child: _buildGrid(null),
    );
  }

  Widget _iosObjectView({required Future<void> Function() onRefresh}) {
    return _buildGrid(onRefresh);
  }

  Widget _buildGrid(Future<void> Function()? iosOnRefresh) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent - 200) {
          if (!allLoaded &&
              !state.isLoadingMore &&
              !state.isErrorMore &&
              !state.isLoading) {
            onLoadMore();
          }
        }
        return false;
      },
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
          if (headerSliver != null) ...headerSliver!,
          if (iosOnRefresh != null)
            CupertinoSliverRefreshControl(
              onRefresh: () => Future.sync(iosOnRefresh),
            ),
          (!state.isLoading)
              ? SliverPadding(
            padding: padding ?? EdgeInsets.zero,
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return itemBuilder(context, index);
                },
                childCount: itemCount,
                addAutomaticKeepAlives:
                addAutomaticKeepAlives ?? true,
                addRepaintBoundaries:
                addRepaintBoundaries ?? true,
                addSemanticIndexes:
                addSemanticIndexes ?? true,
              ),
              gridDelegate: sliverGridDelegate,
            ),
          )
              : SliverFillRemaining(
            hasScrollBody: false,
            child: _getLoadingView(
              loadingView ?? const PlatformLoadingIndicator(),
            ),
          ),
          if (!allLoaded)
            SliverToBoxAdapter(
              child: _buildLoadMoreIndicator(),
            ),
          if (footerSliver != null) ...footerSliver!,
        ],
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    if (state.isErrorMore) {
      return errorLoadMoreView ??
          InkWell(
            onTap: onLoadMore,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.refresh),
                  const SizedBox(width: 8),
                  Text('txt_tap_retry'.tr),
                ],
              ),
            ),
          );
    }

    if (state.isLoadingMore) {
      return loadingMoreView ??
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: PlatformLoadingIndicator(),
          );
    }

    return const SizedBox.shrink();
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