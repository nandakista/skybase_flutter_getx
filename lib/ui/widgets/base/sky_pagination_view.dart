import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/list_pagination/list_empty_view.dart';
import 'package:skybase/ui/widgets/list_pagination/pagination_error_load_view.dart';
import 'package:skybase/ui/widgets/list_pagination/pagination_error_view.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/shimmer_list.dart';

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

  final Widget? emptyImage;

  final String? emptyTitle;

  final String? emptySubtitle;

  final bool enableIOSStyle;

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
            emptyTitle: emptyTitle,
            emptySubtitle: emptySubtitle,
          ),
      firstPageErrorIndicatorBuilder: (ctx) =>
          errorView ?? PaginationErrorView(controller: pagingController),
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
