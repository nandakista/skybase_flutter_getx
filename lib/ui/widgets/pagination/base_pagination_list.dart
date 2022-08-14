import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/pagination/pagination_empty_view.dart';
import 'package:skybase/ui/widgets/pagination/pagination_error_load_view.dart';
import 'package:skybase/ui/widgets/pagination/pagination_error_view.dart';
import 'package:skybase/ui/widgets/pagination/pagination_max_item_view.dart';
import 'package:skybase/ui/widgets/shimmer_list.dart';

typedef ItemWidgetBuilder<ItemType> = Widget Function(
    BuildContext context,
    ItemType item,
    int index,
    );

class PaginationList<ItemType> extends StatelessWidget {
  const PaginationList({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
    required this.onRefresh,
    this.loadingView,
    this.emptyView,
    this.errorView,
    this.errorLoadView,
    this.maxItemView,
  }) : super(key: key);

  final PagingController<int, ItemType> pagingController;
  // final Widget Function(BuildContext, T, int) itemBuilder;

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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // onRefresh: () => Future.sync(() => pagingController.refresh()),
      onRefresh: () => Future.sync(onRefresh),
      child: PagedListView<int, ItemType>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<ItemType>(
          animateTransitions: true,
          firstPageProgressIndicatorBuilder: (ctx) =>
              loadingView ?? const ShimmerList(),
          noItemsFoundIndicatorBuilder: (ctx) =>
              emptyView ?? const PaginationEmptyView(),
          firstPageErrorIndicatorBuilder: (ctx) =>
              errorView ?? PaginationErrorView(controller: pagingController),
          noMoreItemsIndicatorBuilder: (ctx) =>
              maxItemView ?? const PaginationMaxItemView(),
          newPageErrorIndicatorBuilder: (ctx) =>
              errorLoadView ?? const PaginationErrorLoadView(),
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
