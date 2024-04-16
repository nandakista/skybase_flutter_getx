/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/base/pagination/custom_paged/paged_grouped_list.dart';
import 'package:skybase/ui/widgets/grouped_listview.dart';

import 'pagination/pagination_delegate.dart';

enum PaginationGroupType {
  list,
  grid,
}

class PaginationGroupStateView<T, G> extends StatelessWidget {
  const PaginationGroupStateView.list({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.groupHeaderBuilder,
    required this.groupBy,
    this.groupFooterBuilder,
    this.separatorHeader,
    this.separatorGroup,
    this.sortBy = SortBy.asc,
    this.loadingView,
    this.emptyView,
    this.maxItemView,
    this.errorView,
    this.errorLoadView,
    this.shrinkWrap = false,
    this.shrinkWrapFirstPageIndicators = false,
    this.physics,
    this.separator,
    this.onRefresh,
    this.emptyImageWidget,
    this.emptyImage,
    this.errorTitle,
    this.errorSubtitle,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
    this.errorImage,
    this.errorImageWidget,
    this.retryText,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.imageHeight,
    this.imageWidth,
    this.errorTitleStyle,
    this.errorSubtitleStyle,
    this.retryWidget,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.emptyRetryEnabled = false,
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
  }) : type = PaginationGroupType.list;

  // Pagination properties
  final PaginationGroupType type;
  final PagingController<int, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;

  // Grouped
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final G Function(T element) groupBy;
  final Widget? separatorHeader;
  final Widget? separatorGroup;
  final SortBy sortBy;

  // Widget properties
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final double? cacheExtent;
  final Clip? clipBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? primary;
  final bool? reverse;
  final ScrollController? scrollController;
  final String? restorationId;

  // Slivers list
  final ScrollBehavior? scrollBehavior;
  final int? semanticChildCount;
  final double? anchor;
  final Key? center;

  // State properties
  final bool emptyRetryEnabled;
  final Widget? loadingView;
  final Widget? emptyView;
  final Widget? maxItemView;
  final Widget? errorView;
  final Widget? errorLoadView;
  final bool shrinkWrapFirstPageIndicators;
  final VoidCallback? onRefresh;
  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final TextStyle? emptyTitleStyle;
  final TextStyle? emptySubtitleStyle;
  final String? errorImage;
  final Widget? errorImageWidget;
  final String? retryText;
  final double? verticalSpacing;
  final double? horizontalSpacing;
  final double? imageHeight;
  final double? imageWidth;
  final TextStyle? errorTitleStyle;
  final TextStyle? errorSubtitleStyle;
  final Widget? retryWidget;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _iosPaginationView();
    } else {
      return _androidPaginationView();
    }
  }

  Widget _buildChildByType({bool isSliver = false}) {
    if (isSliver) {
      return switch (type) {
        PaginationGroupType.list => _buildPagedSliverGroupedList(),
        PaginationGroupType.grid => _buildPagedSliverGroupedGrid(),
      };
    } else {
      return switch (type) {
        PaginationGroupType.list => _buildPagedGroupedList(),
        PaginationGroupType.grid => _buildPagedGroupedGrid(),
      };
    }
  }

  Widget _androidPaginationView() {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () => Future.sync(onRefresh!),
        child: _buildChildByType(),
      );
    } else {
      return _buildChildByType();
    }
  }

  Widget _iosPaginationView() {
    if (onRefresh != null) {
      return Padding(
        key: key,
        padding: padding ?? EdgeInsets.zero,
        child: CustomScrollView(
          shrinkWrap: shrinkWrap,
          physics: physics,
          scrollDirection: scrollDirection,
          scrollBehavior: scrollBehavior,
          controller: scrollController,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.manual,
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
            CupertinoSliverRefreshControl(
              onRefresh: () => Future.sync(onRefresh!),
            ),
            _buildChildByType(isSliver: true),
          ],
        ),
      );
    } else {
      return _buildChildByType();
    }
  }

  Widget _buildPagedGroupedList() {
    return PagedGroupedListView(
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      groupBy: groupBy,
      groupHeaderBuilder: groupHeaderBuilder,
      groupFooterBuilder: groupFooterBuilder,
      physics: physics,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse ?? false,
      separator: separator,
      separatorGroup: separatorGroup,
      separatorHeader: separatorHeader,
      controller: scrollController,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      primary: primary,
      restorationId: restorationId,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      cacheExtent: cacheExtent,
      keyboardDismissBehavior:
          keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
    );
  }

  Widget _buildPagedSliverGroupedList() {
    return PagedSliverGroupedListView(
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      groupBy: groupBy,
      groupHeaderBuilder: groupHeaderBuilder,
      groupFooterBuilder: groupFooterBuilder,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      separator: separator,
      separatorGroup: separatorGroup,
      separatorHeader: separatorHeader,
    );
  }

  Widget _buildPagedGroupedGrid() {
    // TODO: Implement _buildPagedGroupedGrid
    return const SizedBox.shrink();
  }

  Widget _buildPagedSliverGroupedGrid() {
    // TODO: Implement PagedSliverGroupedGrid
    return const SizedBox.shrink();
  }

  PagedChildBuilderDelegate<T> _builderDelete() {
    return PaginationDelegate<T>(
      pagingController: pagingController,
      onRetry: onRefresh ?? () => pagingController.refresh(),
      loadingView: loadingView,
      emptyView: emptyView,
      emptyRetryEnabled: emptyRetryEnabled,
      emptyTitle: emptyTitle,
      emptyTitleStyle: emptyTitleStyle,
      errorTitleStyle: errorTitleStyle,
      errorTitle: errorTitle,
      errorSubtitle: errorSubtitle,
      errorSubtitleStyle: errorSubtitleStyle,
      errorImage: errorImage,
      errorImageWidget: errorImageWidget,
      retryText: retryText,
      retryWidget: retryWidget,
      maxItemView: maxItemView,
      emptyImage: emptyImage,
      emptyImageWidget: emptyImageWidget,
      emptySubtitle: emptySubtitle,
      emptySubtitleStyle: emptySubtitleStyle,
      verticalSpacing: verticalSpacing,
      horizontalSpacing: horizontalSpacing,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
      itemBuilder: itemBuilder,
      errorLoadView: errorLoadView,
      errorView: errorView,
    );
  }
}
