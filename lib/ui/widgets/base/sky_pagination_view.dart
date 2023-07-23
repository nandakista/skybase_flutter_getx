import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/list_pagination/list_empty_view.dart';
import 'package:skybase/ui/widgets/list_pagination/pagination_error_load_view.dart';
import 'package:skybase/ui/widgets/list_pagination/pagination_error_view.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
typedef ItemWidgetBuilder<ItemType> = Widget Function(
  BuildContext context,
  ItemType item,
  int index,
);

class SkyPaginationView<ItemType> extends StatelessWidget {
  const SkyPaginationView({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
    required this.onRefresh,
    this.loadingView,
    this.emptyView,
    this.errorView,
    this.errorLoadView,
    this.maxItemView,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.enableIOSStyle = false,
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
    this.emptyImageWidget,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
  }) : super(key: key);

  final PagingController<int, ItemType> pagingController;

  // final ItemWidgetBuilder
  final ItemWidgetBuilder<ItemType> itemBuilder;

  final Widget? loadingView;

  /// ** Empty View **
  /// View when data list is empty
  final Widget? emptyView;

  /// ** Error View **
  /// View when all item already loaded
  final Widget? maxItemView;

  /// ** Max Item Indicator/View **
  /// View when initial/first load error
  final Widget? errorView;

  /// ** Error load  ** .
  /// View when load pagination error
  final Widget? errorLoadView;

  final VoidCallback onRefresh;

  final Widget? emptyImageWidget;

  final String? emptyImage;

  final String? errorTitle;

  final String? errorSubtitle;

  final String? emptyTitle;

  final String? emptySubtitle;

  final TextStyle? emptyTitleStyle;

  final TextStyle? emptySubtitleStyle;

  final bool enableIOSStyle;

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
    if (Platform.isIOS) {
      if (enableIOSStyle) return _iosPaginationView();
      return _androidPaginationView();
    } else {
      return _androidPaginationView();
    }
  }

  Widget _androidPaginationView() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(onRefresh),
      child: PagedListView(
        pagingController: pagingController,
        builderDelegate: _builderDelete(),
      ),
    );
  }

  Widget _iosPaginationView() {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => Future.sync(onRefresh),
        ),
        PagedSliverList(
          pagingController: pagingController,
          builderDelegate: _builderDelete(),
        ),
      ],
    );
  }

  PagedChildBuilderDelegate<ItemType> _builderDelete() {
    return PagedChildBuilderDelegate<ItemType>(
      animateTransitions: true,
      newPageProgressIndicatorBuilder: (ctx) =>
          const PlatformLoadingIndicator(),
      firstPageProgressIndicatorBuilder: (ctx) =>
          loadingView ?? const ShimmerList(),
      noItemsFoundIndicatorBuilder: (ctx) =>
          emptyView ??
          ListEmptyView(
            emptyImage: emptyImage,
            emptyImageWidget: emptyImageWidget,
            emptyTitle: emptyTitle,
            emptySubtitle: emptySubtitle,
            titleStyle: emptyTitleStyle,
            subtitleStyle: emptySubtitleStyle,
            horizontalSpacing: horizontalSpacing ?? 24,
            verticalSpacing: verticalSpacing ?? 24,
            imageSize: imageSize,
          ),
      firstPageErrorIndicatorBuilder: (ctx) =>
          errorView ??
          PaginationErrorView(
            errorImage: errorImage,
            errorImageWidget: errorImageWidget,
            errorTitle: errorTitle,
            errorSubtitle: errorSubtitle,
            controller: pagingController,
            horizontalSpacing: horizontalSpacing ?? 24,
            verticalSpacing: verticalSpacing ?? 24,
            titleStyle: errorTitleStyle,
            subtitleStyle: errorSubtitleStyle,
            imageSize: imageSize,
            retryText: retryText,
            retryWidget: retryWidget,
          ),
      // noMoreItemsIndicatorBuilder: (ctx) =>
      //     maxItemView ?? const PaginationMaxItemView(),
      newPageErrorIndicatorBuilder: (ctx) =>
          errorLoadView ??
          PaginationErrorLoadView(
            pagingController: pagingController,
          ),
      itemBuilder: itemBuilder,
    );
  }
}
